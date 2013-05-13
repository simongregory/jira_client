require "jira_client/status"
require "jira_client/timetracking"
require "jira_client/project"
require "jira_client/worklog"

module JiraClient
  class Issue < JiraClient::Base
    attr_reader :key, :description, :summary, :status, :timetracking, :project, :worklog, :comment

    convert :status, JiraClient::Status
    convert :timetracking, JiraClient::Timetracking
    convert :comment, JiraClient::Comment
    convert :project, JiraClient::Project
    convert :worklog, JiraClient::Worklog

    class << self

      def from_response(params)
        # Make values nested in the :fields key top-level values
        params.merge!(params[:fields]).delete :fields if params.has_key? :fields
        super(params)
      end

    end
  end
end