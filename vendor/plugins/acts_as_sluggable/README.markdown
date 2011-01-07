Acts as sluggable readme
========================

Generates a URL slug based on a specific fields (e.g. title).

A url slug is a string derived from a specific field which can the be used in a URL.  For instance, a page with the title <tt>My page</tt> would have a URL slug of <tt>my-page</tt>.

The slug is generated on save and create actions.  If the field has an existing URL slug (like when editing an existing record) the URL slug will be updated.

URL slugs are unique within the specified scope (or all records if no scope is defined).  If the slug already exists within the scope, <tt>-n</tt> is added (e.g. <tt>my-page-0</tt>, <tt>my-page-1</tt>, etc...


Installation
------------
	./script/plugin install git://github.com/volta/acts_as_sluggable.git


Usage examples
--------------

In your target table, add a column to hold the URL slug.


With scope
-------------

	class Page < ActiveRecord::Base
	  acts_as_sluggable :source_column => :title, :slug_column => :url_slug, :scope => :parent
	end

### Without scope

	class Post < ActiveRecord::Base
	  acts_as_sluggable :source_column => :title, :slug_column => :url_slug
	end

###  A sample link

	link_to @page.title, :action => 'show', :url_slug => @page.url_slug


Testing
-------

The unit tests for this plugin use an in-memory sqlite3 database (http://www.sqlite.org/).

To execute the unit tests run the default rake task (<tt>rake</tt>). To execute the unit tests but preserve to debug log run <tt>rake test</tt>.

Credits
-------

Created by Alex Dunae (http://dunae.ca/), 2006-07

Modified by Matt Pelletier (http://eastmedia.com) 2007-2008. Reasons for forking include:

* Uses iconv to clean strings
* Escapes more use cases
* Will slugify based on the named method, not column (if you ever override columns you'll appreciate this).

Modified by Piotr Chmolowski (2010):

* Updating slug on save, not only on create
* Updated documentation
* Renamed slugable to sluggable

Thanks to Andrew White (http://pixeltrix.co.uk/) for fixing a conflict with <tt>acts_as_list</tt>.
