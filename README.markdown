Acts As Daily Countable
=======================

Features
--------

1. Maintains a daily record of the number of entries in a particular model. Both number and comma separated primary_keys are stored.

2. For a particular record of a model, stores the periods during which it was active.


Installation
------------

Write the following like in your rails root to install

	./script/plugin install git://github.com/intinno/acts_as_daily_countable.git

Copy the files ftom the migrations folder to your RAILS_ROOT/db/migrate and run

	db:migrate


Usage
-----

Add the following statement to the model whose records need to be counted daily 

	acts_as_daily_countable 

For Example

	class User < ActiveRecord::Base
		acts_as_daily_countable
	end

Run the task daily_countable:persist_counts to save the count details. 
It is recommended that this rake task should be run atleast once during the day.

To find the count of reocrds that were active on a particular day, use
	
	ClassName.count_on(DateObject) like User.count_on(Date.today)


To find the ids of records that were active on a particular day, use

	ClassName.ids_on(DateObejct) like User.ids_on(Date.today)


To find the activity periods of a certain record
	
	Record.active_periods like User.first.active_periods

This will return the array of time when the user was active. For example [[StartDateObject, EndDateObject]]



TODO
----

1. More comprehensive Documentation

2. Explaning the usage in relation to acts_as_paranoid



Copyright (c) 2009 Udit Sajjanhar, Intinno Technologies Pvt. Ltd.
Released under the MIT license
