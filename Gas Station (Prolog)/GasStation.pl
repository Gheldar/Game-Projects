:- dynamic at/2, i_am_at/1, door/2.

/* Initialization */
i_am_at(car).
door(car_door,closed).
door(gas_station_door,closed).

/* The location of various objects */
at(soda,gas_station).
at(newspaper,gas_station).

/* How are the locations connected */
path(car,exterior):- door(car_door,opened).
path(car,exterior):-
		write('You need to open the car_door first. '),
		fail.
path(exterior,car):- door(car_door,opened).
path(exterior,car):-
		write('You need to open the car_door first. '),
		fail.
path(gas_station,exterior):- door(gas_station_door,opened).
path(gas_station,exterior):-
		write('You need to open the gas_station_door first. '),
		fail.
path(exterior,gas_station):- door(gas_station_door,opened).
path(exterior,gas_station):-
		write('You need to open the gas_station_door first. '),
		fail.
		
/* Moving from one place to another */
goto(There):-
		i_am_at(Here),
		path(Here,There),
		retract(i_am_at(Here)),
		assert(i_am_at(There)),
		write('You went to the '),write(There),write('.').
goto(_):-
		write('You cannot get there from here').

/* The doors' state */
open(car_door):-
		assert(door(car_door,opened)),
		write('Car door is now open. ').
open(gas_station_door):-
		assert(door(gas_station_door,opened)),
		write('Gas station door is now open. ').
open(_):-
		write('There is no such door. ').
		
/* Buying items */
take(X):-
		i_am_at(Place),
		at(X,Place),
		write('You now have a '), write(X), write('.').
take(_):-
		write('I do not see that item. ').

start:-
		write('You just arrived at the gas station and you are in your car. What will you do?'),write('available commands: goto(),open(),buy(),leave.').
		
leave:-
		i_am_at(car),
		write('You drive away...'),
		halt.
leave:-
		i_am_at(_),
		write('You need to get to your car first.').