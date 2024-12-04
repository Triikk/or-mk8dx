int: n_drivers;
int: n_bodies;
int: n_tires;
int: n_gliders;
int: n_statistics;

var float: weight_value;
var float: weight_factor;
var float: acceleration_value;
var float: acceleration_factor;
var float: traction_value;
var float: traction_factor;
var float: mini_turbo_value;
var float: mini_turbo_factor;
var float: speed_value;
var float: speed_factor;
var float: handling_value;
var float: handling_factor;

array[drivers] of string: driver_names;
array[bodies] of string: body_names;
array[tires] of string: tire_names;
array[gliders] of string: glider_names;

array[drivers, statistics] of int: driver_statistics;
array[bodies, statistics] of int: body_statistics;
array[tires, statistics] of int: tire_statistics;
array[gliders, statistics] of int: glider_statistics;

var float: objective_function;

set of int: drivers = 1..n_drivers;
set of int: bodies = 1..n_bodies;
set of int: tires = 1..n_tires;
set of int: gliders = 1..n_gliders;
set of int: statistics = 1..n_statistics;

var drivers: best_driver;
var bodies: best_body;
var tires: best_tire;
var gliders: best_glider;

constraint
    forall(s in statistics) (
        driver_statistics[best_driver, s] + 
        body_statistics[best_body, s] + 
        tire_statistics[best_tire, s] + 
        glider_statistics[best_glider, s] <= 20
    );

% weight (1) + acceleration (2) + avg(traction) (3,4) + mini turbo (5) + avg(speed) (6,7,8,9) + avg(handling) (10,11,12,13)
objective_function = 
    speed_value*speed_factor+ 
    weight_value*weight_factor+
    acceleration_value*acceleration_factor+
    traction_value*traction_factor+
    mini_turbo_value*mini_turbo_factor+
    handling_value*handling_factor;
    
solve maximize objective_function;

output [
    "Best Driver: ", driver_names[fix(best_driver)], "\n",
    "Best Body: ", body_names[fix(best_body)], "\n",
    "Best Tire: ", tire_names[fix(best_tire)], "\n",
    "Best Glider: ", glider_names[fix(best_glider)], "\n",
    "Total Stats: ", show(objective_function), "\n"
];