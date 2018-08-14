# UNCLOG DASHBOARD 
Anclog Dashboard is web application to visualize the aggregated data form
[Unclog Worker](https://github.com/go-squads/unclog-worker).

##Dependencies
- [Rails](https://github.com/rails/rails) v5.2.0
- [ChartJS for Rails](https://github.com/airblade/chartjs-ror)
- Postgresql

##Installation
Make sure that you had installed Ruby, Rails, and Postgresql. Then, create your
database and set your database name on ```config/database.yml```

We don't create database migrator for this project. The data base migrator located
in the Unclog Worker. We choose this to avoid ambiguity.

##Running
To run this project, execute this command ```rails s``` with default port 3000.
If you want to change the port, execute this command ```rails s -p <PORT>```

##Testing
