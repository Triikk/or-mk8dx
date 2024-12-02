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

% var int: total_statistics = sum([driver_statistics[best_driver, s] + 
%                             body_statistics[best_body, s] + 
%                             tire_statistics[best_tire, s] + 
%                             glider_statistics[best_glider, s] | s in statistics]);

% speed (1) + acceleration (2) + avg(traction) (3,4) + mini turbo (5) + avg(speed) (6,7,8,9) + avg(handling) (10,11,12,13)
var int: total_statistics = 
    driver_statistics[best_driver, 1] + body_statistics[best_body, 1] + tire_statistics[best_tire, 1] + glider_statistics[best_glider, 1] +
    
    driver_statistics[best_driver, 2] +  body_statistics[best_body, 2] + tire_statistics[best_tire, 2] + glider_statistics[best_glider, 2] +
    
    (driver_statistics[best_driver, 3] + body_statistics[best_body, 3] + tire_statistics[best_tire, 3] + glider_statistics[best_glider, 3] +
    driver_statistics[best_driver, 4] + body_statistics[best_body, 4] + tire_statistics[best_tire, 4] + glider_statistics[best_glider, 4]) div 2 +
    
    driver_statistics[best_driver, 5] + body_statistics[best_body, 5] + tire_statistics[best_tire, 5] + glider_statistics[best_glider, 5] +
    
    (driver_statistics[best_driver, 6] + body_statistics[best_body, 6] + tire_statistics[best_tire, 6] + glider_statistics[best_glider, 6] +
    driver_statistics[best_driver, 7] + body_statistics[best_body, 7] + tire_statistics[best_tire, 7] + glider_statistics[best_glider, 7] +
    driver_statistics[best_driver, 8] + body_statistics[best_body, 8] + tire_statistics[best_tire, 8] + glider_statistics[best_glider, 8] +
    driver_statistics[best_driver, 9] + body_statistics[best_body, 9] + tire_statistics[best_tire, 9] + glider_statistics[best_glider, 9]) div 4 +
    
    (driver_statistics[best_driver, 10] + body_statistics[best_body, 10] + tire_statistics[best_tire, 10] + glider_statistics[best_glider, 10] +
    driver_statistics[best_driver, 11] + body_statistics[best_body, 11] + tire_statistics[best_tire, 11] + glider_statistics[best_glider, 11] +
    driver_statistics[best_driver, 12] + body_statistics[best_body, 12] + tire_statistics[best_tire, 12] + glider_statistics[best_glider, 12] +
    driver_statistics[best_driver, 13] + body_statistics[best_body, 13] + tire_statistics[best_tire, 13] + glider_statistics[best_glider, 13]) div 4;

constraint
    forall(s in statistics) (
        driver_statistics[best_driver, s] + 
        body_statistics[best_body, s] + 
        tire_statistics[best_tire, s] + 
        glider_statistics[best_glider, s] <= 20
    );

solve maximize total_statistics;

output [
    "Best Driver: ", driver_names[fix(best_driver)], "\n",
    "Best Body: ", body_names[fix(best_body)], "\n",
    "Best Tire: ", tire_names[fix(best_tire)], "\n",
    "Best Glider: ", glider_names[fix(best_glider)], "\n",
    "Total Stats: ", show(total_statistics), "\n"
];