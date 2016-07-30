require 'csv'

namespace :import do
	desc 'Import coin metrics from csv'
	task :coin_metrics => :environment do
		filename = File.join Rails.root ,'csv/coin_metrics.csv'
		counter = 0

		CSV.foreach(filename, headers: true) do |row| 
			p row
			coin = Coin.find(row["coin_id"])
			metric = coin.coin_metrics.create(value: row["value"], 
                                				variation: row["variation"],
                                				created_at: row["created_at"])
			puts "Error - #{metric.errors.full_messages.join(',')}" if metric.errors.any?
			counter += 1 if metric.persisted?
		end
		puts "Imported #{counter} coin metrics"
	end	

	desc 'Import user metrics from csv'
	task :user_metrics => :environment do
		filename = File.join Rails.root ,'csv/user_metrics.csv'
		counter = 0

		CSV.foreach(filename, headers: true) do |row| 
			p row
			user = User.find(row["user_id"])
			metric = user.user_metrics.create(wallet_value: row["wallet_value"],
                                				created_at: row["created_at"])
			puts "Error - #{metric.errors.full_messages.join(',')}" if metric.errors.any?
			counter += 1 if metric.persisted?
		end
		puts "Imported #{counter} user metrics"
	end

	desc 'Import users from csv'
	task :users => :environment do
		filename = File.join Rails.root ,'csv/users.csv'
		counter = 0

		CSV.foreach(filename, headers: true) do |row| 
			p row
			random_password = SecureRandom.urlsafe_base64

			user = User.create(	name:  					row["name"],
             					email: 					row["email"],
             					password:              	random_password,
             					password_confirmation: 	random_password,
             					activated: 				true,
             					activated_at: 			Time.zone.now) 

			puts "#{row['email']} - #{user.errors.full_messages.join(',')}" if user.errors.any?
			if user.persisted?
				counter += 1 
				user.create_reset_digest
      			user.send_password_reset_email
      		end
		end
		puts "Imported #{counter} users"
	end
end