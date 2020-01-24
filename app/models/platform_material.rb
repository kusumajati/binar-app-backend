# frozen_string_literal: true

class PlatformMaterial < ApplicationRecord
  acts_as_paranoid

  belongs_to :platform, optional: true
  belongs_to :level, optional: true
  has_many :chapters, dependent: :destroy

  validates_presence_of :title, :description

  def self.get_material(id,level,platform)
    data = User.find(id)
    material = PlatformMaterial.find_by(level_id: level, platform_id: platform)
    chapter = Chapter.where(platform_material_id: material.id)
    topics = []
    chapter.each do |val|
      topics << Topic.where(chapter_id: val.id)
    end

    res = []
    chapter.each do |v|
      obj = {}
      obj["id"] = v.id
      obj["name"] = v.name
      topc = Topic.select("id, title, is_active").where(chapter_id: v.id)
      
      dat = []
      topc.each do |val|
        objs = {}
        objs[:id] = val.id
        objs[:title] = val.title
        objs[:is_active] = val.is_active
        objs[:answered] = StudentAnswer.where(student_id: id, topic_id: val.id).count
        objs[:total_question] = MaterialQuestion.where(topic_id: val.id).count
        dat << objs
      end

      obj["topics"] = dat

      res << obj
    end

    

    result = {
      level: data.level.name,
      platform: data.platform.label,
      title: material.title,
      description: material.description,
      photo: material.photo,
      chapters: res
    
    }
    return result
  end

end
