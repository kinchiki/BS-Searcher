class Company < ActiveRecord::Base
  has_many :briefing_sessions, :dependent => :destroy
  belongs_to :sub_industry

  validates :com_name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :head_office, presence: true, length: { in: 2..20 }
  validates :employees_number, presence: true, numericality: { only_integer: true, less_than: 350000 }
  # validates :sub_industry_id, presence: true

  scope :employees_between, -> from, to {
    if from.present? && to.present?
      where(employees_number: from..to)
    elsif from.present?
      where('employees_number >= ?', from)
    elsif to.present?
      where('employees_number <= ?', to)
    end
  }
  scope :include_sub, -> types {
    if types.present?
      types =  types.delete("\"[],").split
      query = ""
      s_like = "sub_str like"
      if types.size == 1
        query = "#{s_like} '%#{types[0]}%'"
      else
        (types.size-1).times do |i|
          query += "#{s_like} '%#{types[i]}%' or "
        end
        query += "#{s_like} '%#{types.last}%'"
      end
      where(query)
    end
  }

  scope :search_head, -> place {
    where(head_office: place) if place.present?
  }
end
