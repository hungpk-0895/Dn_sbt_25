class Tour < ApplicationRecord
  acts_as_paranoid
  belongs_to :category
  enum status: {opening: 0, full: 1, finished: 2}
  has_many :bookings
  has_many :reviews

  mount_uploader :picture, PictureUploader

  validates :name, presence: true,
    length: {maximum: Settings.valid.name.max_length}
  validates :description, presence: true
  validates :detail, presence: true
  validates :price, presence: true
  validates :place, presence: true
  validates :status, presence: true
  validates :start_time, presence: true
  validates :finish_time, presence: true

  scope :top_rates, ->{order(score: :desc)}
  scope :top_views, ->{order(count_views: :desc)}
  scope :new_tours, ->{order(created_at: :desc)}
  scope :search_place, ->(key){where("place LIKE :place", place: "%#{key}%")}
  scope :tour_opening, ->{where(status: :opening)}

  class << self
    def find_tour name
      @tour = Tour.find_by name: name
      return true if @tour.present?
      false
    end

    def import_file file, overwrite
      init_file(file)
      import @header, @tours if @tours.any?
      if @tours_update.any? && overwrite.present?
        Tour.import @header, @tours_update,
          on_duplicate_key_update: [:description, :detail, :place, :price,
            :start_time, :finish_time, :status, :category_id]
      end
      {
        counter_created: @counter_created,
        counter_updated: @counter_updated,
        counter_error_category: @counter_error_category,
        counter_error_status: @counter_error_status
      }
    end

    def init_file file
      spreadsheet = open_spreadsheet(file)
      @header = %w(name description detail place price
        start_time finish_time status category_id)
      @tours = []
      @tours_update = []
      @counter_created = 0
      @counter_updated = 0
      @counter_error_status = 0
      @counter_error_category = 0
      read_file(spreadsheet)
    end

    def read_file spreadsheet
      (2..spreadsheet.last_row).each do |i|
        @row = spreadsheet.row(i)[1..9]
        category_id = find_category(@row[8])
        unless category_id.present?
          @counter_error_category += 1
          next
        end
        @row[8] = category_id
        unless check_status(@row[7])
          @counter_error_status += 1
          next
        end
        if find_tour(@row[0])
          @tours_update << @row
          @counter_updated += 1
        else
          @tours << @row
          @counter_created += 1
        end
      end
    end

    def open_spreadsheet file
      case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end

    def find_category name
      category = Category.sub_categories.find_by name: name
      return category.id if category.present?
      false
    end

    def check_status stt
      return true if Tour.statuses[stt].present?
      false
    end

    def update_tour
      @tours_update << @row
    end

    def create_tour
      @tours << @row
    end
  end
end
