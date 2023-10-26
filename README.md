
# :bangbang: WARNING 
## :no_entry: if you are not already aware of this project and has not been invited to work on THIS repo.

"Org4g" is a fake organisation, owned by a personal GithHub account.

This is a proof of concept, not a fully working organisation, neither repo.

It began in october 2023 and is STILL ON PROGRESS :construction_worker:...

THIS repo is made public for demo and test purposes between private members of Org4g organisation.




# :wave: Members of Org4g PoC


## :bulb: IDEA BEHIND THIS...

Lets think of "poc", also as "Point of Contact" in this scenario.

Try to:
+ Keep it simple and explain (Comment as much as possible)
+ Focus on what is needed (Ensure priority orders)
+ Trust and transparency ("Behind the scene..." thing)

This project (or its future copy/clone in other organization) aims at becoming the Entrypoint for Volunteers and Project Owners of Org4g boosted projects hosted on GitHub (and GitLab? TODO in second phase, if needed).

It aims at helping cross collaboration on Org4g projects, in onboarding :rocket: and coding phase.

The ultimate goal is also to connect to external tools, mainly Slack and Notion.

3 main automated workflows exist in THIS repo:

 :recycle: ***Volunteers*** (People willing to collaborate on Org4g's boosted projects)

 :recycle: ***Owners*** (People owning a project that has been accepted as part of an Org4g's season )  

 ( and :x: **Admin**, for Org4g members only)


# **WORKFLOWS**


## :recycle: ***Volunteers***

You want to contribute on Org4g's projects,

**Prerequisites**:

:white_check_mark: You have a github account

:white_check_mark: You are connected to your github account

:white_check_mark: You have been invited to contribute as Volunteer in Org4g's projects (via Slack)

### Onboarding :rocket: 
To jump in, it is fairly simple.

The only action you need to take is : 
 
#### > **Click on "Star" button on this page to :star: THIS repo**

     
    Behind the scene... 

    Github actions will be triggered:
      + Create issue "Volunteer Invitation Pending for ..." in THIS repo
      + Send actual Invitation to you on your github account
    
    
**IMPORTANT, check your emails**:exclamation:**YOU, as a volunteer, will then need to accept invitation** that has been notified to you via email (Sender is Github) and/or visible on THIS repo from your github account.

**As soon as YOU accept the invitation**, you will be part of the "Volunteers" Team in Org4g organization. Your role is set to "Member".

 
    Behind the scene... 

    Github actions will be triggered:
      + Close issue "Volunteer Invitation Pending for ..." in THIS repo
    

### Lets code :wink: 

Now that you are all set, you want to contribute and go hands on. Lets start!

We recommend to use VS Code (Integrated terminal feature is included) for a great experience when contributing on several remote projects with Github.

We created a Makefile (at the root of THIS repo) that ease interactions with remote repos.

The action allowed are the following:
#### TODO


## :recycle: ***Owners*** 

You own a project that have been approved by Org4g ,

### Setup your project in Org4g repo :unlock: 
**Prerequisites**:

:white_check_mark: You have a github account

:white_check_mark: You are connected to your github account

:white_check_mark: You have been accepted as Owner in Org4g's organization (via Slack)


    Behind the scene... 

    Github actions will be triggered and it will accomplish the following steps:

        + Create issue "Collaborator Access Request on ..." in YOUR repo
        + Send Collaborator Access Request for Org4g organization to YOUR repo 


**IMPORTANT**:exclamation:**YOU, as an owner, will then need to add us as collaborator on your project repo**.

Why :question:: Org4g will need to perform some actions on your repo, like copy configuration folder to you repo, create branch dedicated to volunteers, manage issues and PR,....

Note that transparency is crucial for us, and please do not hesitate to ask any question on Org4g automation processes.

As soon as you accept the Collaborator Access Request :

    Behind the scene... 

    Github actions will be triggered:

        + Close "Collaborator Access Request on ..." issue in YOUR repo
        + Create branch in YOUR repo (like org4g-volunteers to ensure separation) (Way to go? , directly on main ??)
        + Create submodule in THIS repo (linked to the new branch in your repo) 


## :x: ***Admin*** (reserved)

You have been invited to contribute to this repo.
Please provide any feedback, doubt, idea...

