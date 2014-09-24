#purger = PurgeOpportunities.new
#purger.purge!

class PurgeOpportunities

  def initialize
    @opportunities = Opportunity.all
  end

  def purge_old_and_never_evaluated!
    @opportunities.each do |opportunity| 
      if old?(opportunity)
        if has_team_evaluation?(opportunity)
          opportunity.evaluations.each do |evaluation|
            if evaluation_is_in_initial_state_of_not_evaluated?(evaluation)
              evaluation.destroy   #I think the opportunity reevaluates and remakes before it gets cleared. Evaluation.where(opportunity_id:5).last => 6601
            end
          end
        else  #the opportunity is not part of any team's evaluation criteria
          opportunity.destroy
        end
      end
    end
  end

  def old?(opportunity)
    (Date.today - opportunity.post_date).to_i > 3 #over a 4 old is a purge opportunity
  end

  def has_team_evaluation?(opportunity)
    opportunity.evaluations.present?
  end 

  def evaluation_is_in_initial_state_of_not_evaluated?(evaluation)
    evaluation.evaluation_code_id == 1 #purge only if team opportunity is not evaluated
  end

end

