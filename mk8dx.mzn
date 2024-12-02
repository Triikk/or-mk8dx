include "mk8dx_data.dzn";

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

solve maximize objective_function;

output [
    "Best Driver: ", driver_names[fix(best_driver)], "\n",
    "Best Body: ", body_names[fix(best_body)], "\n",
    "Best Tire: ", tire_names[fix(best_tire)], "\n",
    "Best Glider: ", glider_names[fix(best_glider)], "\n",
    "Total Stats: ", show(objective_function), "\n"
];