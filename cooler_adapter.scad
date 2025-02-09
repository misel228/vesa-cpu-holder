
wall_strength = 2;
adapter_width = 110;
adapter_length = 110;

cooler_width = 69.5; // nice
cooler_length = 77.5;

corner_radius = 5;
screw_hole_radius = 2;

inner_hook_distance = 94;
hook_width = 6;
outer_hook_distance = 100;

fence_height = 8;

// the whole project consists of two big unions.
// one is all the positives. Base plate, fence and hooks
// the other are the negatives for the big hole in the middle,
// the bore holes and the rounded corners

// change this to union to see how this is build
difference() {
    // positives
    union () {
        // base plate
        cube([
            adapter_length,
            adapter_width,
            wall_strength
        ]);
        translate([
            (adapter_width - cooler_width - 2 * wall_strength) / 2,
            (adapter_length - cooler_length - 2 * wall_strength) / 2,
            0]) {
            
            // fence
            cube([
                cooler_width + 2 * wall_strength, 
                cooler_length + 2 * wall_strength, 
                fence_height
            ]);
        }
        //hook lower part
        translate([
            (adapter_length - hook_width) / 2,
            (adapter_width - inner_hook_distance) / 2,
            0]) {
            color("#ff0000") 
            cube([
                hook_width, 
                inner_hook_distance, 
                3 + wall_strength
            ]);
        }

        // hook upper part
        translate([
            (adapter_length - hook_width) / 2,
            (adapter_width - outer_hook_distance) / 2,
            3 + wall_strength]) {
            color("#ff0000") 
            cube([
                hook_width, 
                outer_hook_distance, 
                3
            ]);
        }
    }
    // positives
    union() {
        // every corner is basically a cube with a quarter-cylindrical cutout
        // which is then used to subtract from a base plate and get a nice round corner
        // TODO: Find if there's some better way to do this.
        translate([-1 * corner_radius ,-1 * corner_radius ,-1 * corner_radius ]) {
            difference () {
                cube ([
                    2 * corner_radius,
                    2 * corner_radius,
                    2 * corner_radius
                ]);
                translate([2 * corner_radius,2 * corner_radius,0]) {
                    cylinder(30,corner_radius,corner_radius);
                }
            }
        }
        translate([
                (corner_radius) + adapter_width ,
                (-1 * corner_radius),
                (-1 * corner_radius) 
                ]) {
            rotate(a = 90, v=[0,0,10]) {
                difference () {
                    cube ([
                        2 * corner_radius,
                        2 * corner_radius,
                        2 * corner_radius
                    ]);
                    translate([2 * corner_radius,2 * corner_radius,0]) {
                        cylinder(30,corner_radius,corner_radius);
                    }
                }
            }
        }
        translate([
                (corner_radius) + adapter_length ,
                (corner_radius) + adapter_width ,
                (-1 * corner_radius) 
                ]) {
            rotate(a = 180, v=[0,0,10]) {
                difference () {
                    cube ([
                        2 * corner_radius,
                        2 * corner_radius,
                        2 * corner_radius
                    ]);
                    translate([2 * corner_radius,2 * corner_radius,0]) {
                        cylinder(30,corner_radius,corner_radius);
                    }
                }
            }
        }

        translate([
                (-1 * corner_radius),
                (corner_radius) + adapter_width ,
                (-1 * corner_radius) 
                ]) {
            rotate(a = 270, v=[0,0,10]) {
                difference () {
                    cube ([
                        2 * corner_radius,
                        2 * corner_radius,
                        2 * corner_radius
                    ]);
                    translate([2 * corner_radius,2 * corner_radius,0]) {
                        cylinder(30,corner_radius,corner_radius);
                    }
                }
            }
        }

        
        // every screw hole is just a cylinder subtracted from base plate
        translate([5,5,0]) {
            cylinder(30,screw_hole_radius,screw_hole_radius,true);
        }
        translate([105,5,0]) {
            cylinder(30,screw_hole_radius,screw_hole_radius,true);
        }
        translate([5,105,0]) {
            cylinder(30,screw_hole_radius,screw_hole_radius,true);
        }
        translate([105,105,0]) {
            cylinder(30,screw_hole_radius,screw_hole_radius,true);
        }

        // the final space in the middle is a cube cutout
        translate([
            (adapter_width - cooler_width) / 2,
            (adapter_length - cooler_length) / 2,
            -30]) {
            color("#ff9900") cube([cooler_width, cooler_length, 60]);
        }
    }
}
