# Help Desk Application #

Access point [https://pacific-savannah-8641.herokuapp.com/](https://pacific-savannah-8641.herokuapp.com/)

A simple system for tracking incoming enquiries from customers with an easy to use interface for support staff to communicate with clients.

## Main Features ##

### Customer Interface Features ###

* Customers do not need to login to submit a query – they simply will need to provide their name and email address, the subject of their enquiry and the full body of the request. That page should have root url (“/“).

* When a new ticket is added, the customer receives an email confirming their request has been received along with their unique reference. This email includes a URL which can be used to view the ticket’s history and update tickets. 

* User may submit few screenshots - and they will be visible for staff as clickable thumbnails; 

* Protect form from spam without captcha; 

* User may select the the issue relates department;


### Staff Interface Features ###

* Each member of staff team has a username & password, used to login to the system. There is 2 different roles: 
  * admin, which can add new member and edit/delete other member posts 
  * member, can response to customer post, edit own response 
* Staff can view a list of all unassigned, open tickets and take ownership. 
* Staff is able to reply to the ticket by simply entering their response into a text field. As part of the same action, they should also be able to change the owner or status. 
* All replies is be e-mailed to the client.
* Each ticket is assigned a status: ʻWaiting for Staff Responseʼ, ʻWaiting for Customerʼ, ʻOn Holdʼ, ʻCancelledʼ or ʻCompletedʼ - status(-es) may wish to be added in the future.
* When a ticket is first created or updated by the customer, it is assigned the ʻWaiting for Staff Responseʼ status.
* The interface has four main views:
  1. New unassigned tickets 
  2. Open Tickets
  3. On hold tickets
  4. Closed Tickets
  5. Manage members (visible only for admin) 
  6. Change password page 
* Staff is able to quickly open up a new ticket by entering itʼs reference number into a search field.


### Additional Features ###

* Staff may want to add few screenshots too and they will be visible as clickable thumbnails;
* Staff may also wish to search based on the ticket subject;
* Staff members may look for words or combinations of words found in the ticket;
* All changes to the status, owner and response are tracked and visible to all staff members. 
* Admin can add/edit/delete departments, change department of staff members; 
* There is a possibility to separate departments issues for staff members, so members of one department can view only own department issues and add possibility for staff members to change department. 


## Preparation ##

1. Before getting started run `rackup faye.ru -s thin -E production`

