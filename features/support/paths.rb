module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page|the login page/
      '/'
    when /the new feature page/
      new_feature_path

    when /the new login page/
      new_login_path

    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    when /manage my team/
        pending # session variables with cucumber are not implemented to pass authentication 
        user = User.find_by_name("student")
        "student_team/view/#{user.id}"

    when /edit my team/
        pending # There must exist a team 
        team = AssignmentTeam.first.id
       "student_team/edit/#{team}"

    when /Your Work/
        user_id = User.find_by_name("student").id
        assignment_id = Assignment.find_by_name("my_assignment").id
        participant = Participant.find_by_user_id_and_parent_id(user_id, assignment_id)
        "submitted_content/view?id=#{participant.id}"

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
