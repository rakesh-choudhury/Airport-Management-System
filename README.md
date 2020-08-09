# Airport-Management-System
## Database Purpose:
* Airline reservation system is one of the most used database systems in the world. It is an example of Transaction processing systems. Transaction processing systems are systems with large databases and hundreds of concurrent users executing database transactions. These systems require high availability and fast response time for hundreds of concurrent users.</br>
* We define the concept of a transaction, which is used to represent a logical unit of database processing, that must be completed in its entirety to ensure correctness. A transaction is typically implemented by a computer program, which includes database commands such as retrievals, insertions, deletions, and updates.
* The system that is being described in here handles everything that the most practical systems would do. The complexity of the database system has been handled by trying to make most basic entities resembling the real world objects.
* Our database handles the most basic functions of an airline reservation system, including reservation, cancellation and updating of a flight trip transaction. 
## Feasibility Study & Risk Analysis:
* It is the most difficult area to assess because objectives, functions, and performance are somewhat hazy; anything seems possible if right assumptions are made.
* A clinical attitude should prevail during an evaluation of technical feasibility. The considerations normally attached with the technical feasibility: 
## Economical Feasibility: 
* An evaluation of development cost weighed against the ultimate income or benefit derived from the development system or product. It includes a broad range of concerns such as:
- Cost-benefit Analysis
- Long-term corporate income strategies
- Impact on other profits/products
- Cost of resources needed for development
- Potential market growth
- The work being done is economically feasible since the work is not being done at a very large scale, although it might be a bit complex. The cost of resources needed to do the work would not be big. The whole task could be completed by a single resource in a given time. 

## Business Rule:
* One Airplane Company can have 0 or more airplanes
* One Airplane can have one or more seats
* One Airport can have Access to 0 or more Airplanes
* One Airplane can have Access to 0 or 1 Airport
* One Airplane can have 0 or 1 schedule
* One Airplane can have 1 or more seats
* One user can book 0 or more Passengers for a flight
* One Air Schedule can have 1 or more Passenger Itinerary
* One Passenger can have multiple Passenger Itinerary
* Booking of each user can be calculated from 1 or more Passenger Itinerary
* One Airplane Can be given 1 Base Fare
* One Hotel can have 0 or more rooms available
* One Hotel booking can have 1 Available Room
* One user can have 0 or more Hotel bookings
* One Airport can have 0 or more Parking spots available
* One Airport can have 0 or more Restaurants available
