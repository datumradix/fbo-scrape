require 'test_helper'

class PurgeOpportunitiesTest < ActiveSupport::TestCase

  test "#purge_old_and_never_evaluated" do
    old = Opportunity.create(opportunity: 'old', post_date: 6.days.ago)
    bad = Opportunity.create(opportunity: 'bad', post_date: 4.weeks.ago)
    bad.evaluations.create(evaluation_code_id: 1)
    good = Opportunity.create(opportunity: 'good', post_date: Date.today)
    good.evaluations.create(evaluation_code_id: 3)
    old_good = Opportunity.create(opportunity: 'old_good', post_date: 1.month.ago)
    old_good.evaluations.create(evaluation_code_id: 2)

    purger = PurgeOpportunities.new
    purger.purge_old_and_never_evaluated!
    all = Opportunity.all

    assert !all.include?(old), 'old is not gone :('
    assert !all.include?(bad), 'bad is not gone :('
    assert all.include?(good), 'good not here :('
    assert all.include?(old_good), 'old_good not here :('
  end

end
