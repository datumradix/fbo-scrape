#purger = PurgeOpportunities.new
#purger.purge!

class PurgeOpportunities

  def purge_old_and_never_evaluated!
    purge_never_evaluated!
    purge_never_evaluated_opportunities!
  end

  # private

  def old_opportunities
    Opportunity.where('post_date < ?', 5.days.ago)
  end

  def purge_never_evaluated!
    old_opportunities.each do |opportunity| 
      if has_team_evaluation?(opportunity)
        opportunity.evaluations.each do |evaluation|
          if evaluation_is_in_initial_state_of_not_evaluated?(evaluation)
            evaluation.destroy  
          end
        end
      end
    end
  end

  def purge_never_evaluated_opportunities!
    old_opportunities.each do |opportunity|
      unless has_team_evaluation?(opportunity)
        opportunity.destroy
      end
    end
  end

  def has_team_evaluation?(opportunity)
    opportunity.evaluations.present?
  end 

  def evaluation_is_in_initial_state_of_not_evaluated?(evaluation)
    evaluation.evaluation_code_id == 1 ||  #purge only if team opportunity is not evaluated
    evaluation.evaluation_code_id == 3  #purges rejects
  end

end


#use select
=begin 
def old_opportunities
  @opportunities.select{|opportunity| evaluate_is_in_initial_state_of_not_evaluated?() }
end

old_opportunities.each(&:destroy)
old_opportunities.each {|opp| opp.destroy }
=end 