module SurveyHelper

  def self.get_assigned_surveys(assignment_id)
      joiners = AssignmentsQuestionnaires.find(:all, :conditions => ["assignment_id = ?", assignment_id])
      assigned_surveys = []
      for joiner in joiners
        survey = Questionnaire.find(joiner.questionnaire_id)
        assigned_surveys << survey if survey.type_id == 2
      end
      assigned_surveys.sort!{|a,b| a.name <=> b.name} 
    end

  def self.get_global_surveys
      global_surveys = Questionnaire.find(:all, :conditions => ["type_id = ? and private = ?", 3, false])
      global_surveys.sort!{|a,b| a.name <=> b.name} 
   end

  def self.get_all_available_surveys(assignment_id, role)
    surveys = SurveyHelper::get_assigned_surveys(assignment_id) 
    unless role == 2
      surveys += SurveyHelper::get_global_surveys
    end
    surveys.sort!{|a,b| a.name <=> b.name}
  end
end