/**
* Description:
* initialize and mark all sector, flag and beam positions
*
* Author:
* form
*
* Arguments:
*
* Return Value:
*
* Server Only:
* Yes
*
* Global:
* No
*
* API:
* No
*
* Example:
* [] call fnc_setupsectors.sqf;

Diese Datei enthält alle Sektoren-, Flaggen- sowie Beam-Positionen. Die Flaggenpositionen werden später durch Auswahl des Angriffssektors der entsprechenden Fraktion zugewiesen.
Jede Flagge hat eine 3D-Koordinate - Kopiert aus dem EDEN-Editor über "Log -> Log position to clipboard" - Die Z-Koordinate ist meistens 0, muss es aber nicht sein.
Auf der Karte werden noch vor Missionsstart die MineZoneMarkers sowie die Sektoren eingezeichnet (später aber wieder gelöscht und nur durch die Aktiven Fahnen ersetzt).
*/

#include "macros.hpp"

GVAR(AllSectors) = [];

if (worldName == "vt7") then
{
    GVAR(AllSectors) =
    [
        [    // Sektor 0
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
            ],

            [   // Beam-Positionen
            ]
        ],

        [    // Sektor 1
            [   // Sektormarker
                [[4157.532, 18000], [0, 18000]],
                [[0, 18000], [0, 16056.343]],
                [[0, 16056.343], [2909.158, 15590.489]],
                [[2909.158, 15590.489], [5958.759, 11770.045]],
                [[5958.759, 11770.045], [5071.521, 14833.756]],
                [[5071.521, 14833.756], [4157.532, 18000]]
            ],

            [   // Flaggen-Positionen
                [1041.75, 16821.9, 0],
                [4752.63, 13806.3, 0]
            ],

            [   // Beam-Positionen
                [4205.25, 14984.3, 0],
                [1413.83, 16107, 0]
            ]
        ],

        [    // Sektor 2
            [   // Sektormarker
                [[7000, 18000], [4157.532, 18000]],
                [[4157.532, 18000], [5071.521, 14833.756]],
                [[5071.521, 14833.756], [8116.663, 13920.995]],
                [[8116.663, 13920.995], [8095.485, 16000]],
                [[8095.485, 16000], [7000, 16000]],
                [[7000, 16000], [7000, 18000]]
            ],

            [   // Flaggen-Positionen
                [6813.25, 14735, 0],
                [6155.13, 16591.1, 0]
            ],

            [   // Beam-Positionen
                [8041.95, 14331.1, 0],
                [5241.34, 15407.7, 0]
            ]
        ],

        [    // Sektor 3
            [   // Sektormarker
                [[10732.676, 14552.906], [10000, 16000]],
                [[10000, 16000], [8095.485, 16000]],
                [[8095.485, 16000], [8116.663, 13920.995]],
                [[8116.663, 13920.995], [9521.084, 13951.086]],
                [[9521.084, 13951.086], [10732.676, 14552.906]]
            ],

            [   // Flaggen-Positionen
                [10115.4, 14917.3, 0],
                [9303.75, 14289.4, 0]
            ],

            [   // Beam-Positionen
                [8267.69, 14410.3, 0],
                [10023.1, 15587.7, 0]
            ]
        ],

        [    // Sektor 4
            [   // Sektormarker
                [[15016.161, 18000], [10000, 18000]],
                [[10000, 18000], [10000, 16000]],
                [[10000, 16000], [10732.676, 14552.906]],
                [[10732.676, 14552.906], [13423.369, 15888.056]],
                [[13423.369, 15888.056], [15016.161, 18000]]
            ],

            [   // Flaggen-Positionen
                [12073.8, 17098.9, 0],
                [11817, 16261.4, 0]
            ],

            [   // Beam-Positionen
                [10933.7, 15512, 0],
                [14135.9, 17057.5, 0]
            ]
        ],

        [    // Sektor 5
            [   // Sektormarker
                [[18000, 17217.633], [18000, 18000]],
                [[18000, 18000], [15016.161, 18000]],
                [[15016.161, 18000], [13423.369, 15888.056]],
                [[13423.369, 15888.056], [10732.676, 14552.906]],
                [[10732.676, 14552.906], [13073.379, 13935.483]],
                [[13073.379, 13935.483], [14608.211, 15932.635]],
                [[14608.211, 15932.635], [18000, 17217.633]]
            ],

            [   // Flaggen-Positionen
                [15386.4, 16696.5, 0],
                [13166.2, 15085.6, 0]
            ],

            [   // Beam-Positionen
                [13377, 14461.8, 0],
                [14543.2, 16781.8, 0]
            ]
        ],

        [    // Sektor 6
            [   // Sektormarker
                [[13934.980, 13709.244], [15208.991, 14663.240]],
                [[15208.991, 14663.240], [16448.448, 14390.192]],
                [[16448.448, 14390.192], [18000, 15499.102]],
                [[18000, 15499.102], [18000, 17217.633]],
                [[18000, 17217.633], [14608.211, 15932.635]],
                [[14608.211, 15932.635], [13073.379, 13935.483]],
                [[13073.379, 13935.483], [13934.980, 13709.244]]
            ],

            [   // Flaggen-Positionen
                [14487, 14696, 0],
                [15967.9, 14971.9, 0.75]
            ],

            [   // Beam-Positionen
                [14868.4, 15104, 0],
                [16978.9, 15408.7, 0]
            ]
        ],

        [    // Sektor 7
            [   // Sektormarker
                [[14976.035, 11038.944], [14600, 9600]],
                [[14600, 9600], [17800, 9600]],
                [[17800, 9600], [17800, 7752.337]],
                [[17800, 7752.337], [18000, 7750.108]],
                [[18000, 7750.108], [18000, 15499.102]],
                [[18000, 15499.102], [16448.448, 14390.192]],
                [[16448.448, 14390.192], [15208.991, 14663.240]],
                [[15208.991, 14663.240], [13934.980, 13709.244]],
                [[13934.980, 13709.244], [14976.035, 11038.944]]
            ],

            [   // Flaggen-Positionen
                [15304.5, 12128.9, 0],
                [14917.3, 14007.4, 0]
            ],

            [   // Beam-Positionen
                [15561.8, 14316.6, 0],
                [15095, 12134.1, 0]
            ]
        ],

        [    // Sektor 8
            [   // Sektormarker
                [[12498.235, 5498.854], [13888.166, 5067.549]],
                [[13888.166, 5067.549], [18000, 5002.910]],
                [[18000, 5002.910], [18000, 7750.108]],
                [[18000, 7750.108], [17800, 7752.337]],
                [[17800, 7752.337], [17800, 6200]],
                [[17800, 6200], [14600, 6200]],
                [[14600, 6200], [14600, 7714.444]],
                [[14600, 7714.444], [13000.928, 7726.704]],
                [[13000.928, 7726.704], [12498.235, 5498.854]]
            ],

            [   // Flaggen-Positionen
                [12893.1, 5724.88, 0],
                [13807.1, 6349.63, 0]
            ],

            [   // Beam-Positionen
                [15474.2, 5833.27, 0],
                [13583.6, 6414.02, 0]
            ]
        ],

        [    // Sektor 9
            [   // Sektormarker
                [[15615.827, 0], [18000, 0]],
                [[18000, 0], [18000, 5002.910]],
                [[18000, 5002.910], [13888.166, 5067.549]],
                [[13888.166, 5067.549], [13365.409, 3646.585]],
                [[13365.409, 3646.585], [15615.827, 0]]
            ],

            [   // Flaggen-Positionen
                [16636.8, 4380.63, 0],
                [14166.4, 4220.24, 0]
            ],

            [   // Beam-Positionen
                [16614.4, 4064.32, 0],
                [14317, 4833.26, 0]
            ]
        ],

        [    // Sektor 10
            [   // Sektormarker
                [[11000, 4000], [11000, 200]],
                [[11000, 200], [9000, 200]],
                [[9000, 200], [9000, 0]],
                [[9000, 0], [15615.827, 0]],
                [[15615.827, 0], [13365.409, 3646.585]],
                [[13365.409, 3646.585], [13888.166, 5067.549]],
                [[13888.166, 5067.549], [12498.235, 5498.854]],
                [[12498.235, 5498.854], [11378.041, 6520.834]],
                [[11378.041, 6520.834], [11000, 4000]]
            ],

            [   // Flaggen-Positionen
                [12017.4, 4292.25, 0],
                [13040.8, 3524.1, 0]
            ],

            [   // Beam-Positionen
                [13281.1, 5047.44, 0],
                [11973.3, 5229.2, 0]
            ]
        ],

        [    // Sektor 11
            [   // Sektormarker
                [[5528.515, 5988.112], [5372.468, 6652.343]],
                [[5372.468, 6652.343], [3774.103, 3636.555]],
                [[3774.103, 3636.555], [5314.508, 0]],
                [[5314.508, 0], [9000, 0]],
                [[9000, 0], [9000, 200]],
                [[9000, 200], [7000, 200]],
                [[7000, 200], [7000, 4000]],
                [[7000, 4000], [7651.866, 4000]],
                [[7651.866, 4000], [5528.515, 5988.112]]
            ],

            [   // Flaggen-Positionen
                [5452.26, 5663.07, 0],
                [5397.25, 4473.25, 0]
            ],

            [   // Beam-Positionen
                [6755.55, 4251.53, 0],
                [5101.18, 5515.61, 0]
            ]
        ],

        [    // Sektor 12
            [   // Sektormarker
                [[0, 3780.323], [0, 0]],
                [[0, 0], [5314.508, 0]],
                [[5314.508, 0], [3774.103, 3636.555]],
                [[3774.103, 3636.555], [0, 3780.323]]
            ],

            [   // Flaggen-Positionen
                [932.028, 2923.79, 0],
                [2551.75, 1949.25, 0]
            ],

            [   // Beam-Positionen
                [1955.78, 1851.97, 0],
                [339.221, 3308.02, 0]
            ]
        ],

        [    // Sektor 13
            [   // Sektormarker
                [[5112.762, 8218.190], [3616.942, 8250.510]],
                [[3616.942, 8250.510], [2948.170, 5462.076]],
                [[2948.170, 5462.076], [1904.885, 5473.221]],
                [[1904.885, 5473.221], [0, 3780.323]],
                [[0, 3780.323], [3774.103, 3636.555]],
                [[3774.103, 3636.555], [5372.468, 6652.343]],
                [[5372.468, 6652.343], [5112.762, 8218.190]]
            ],

            [   // Flaggen-Positionen
                [1245, 4647.38, 0],
                [3713.58, 6926.41, 0]
            ],

            [   // Beam-Positionen
                [1032.84, 4028.45, 0],
                [4000.8, 5573.88, 0],
                [3997.36, 7395.92, 0]
            ]
        ],

        [    // Sektor 14
            [   // Sektormarker
                [[0, 8000], [0, 3780.323]],
                [[0, 3780.323], [1904.885, 5473.221]],
                [[1904.885, 5473.221], [2948.170, 5462.076]],
                [[2948.170, 5462.076], [3616.942, 8250.510]],
                [[3616.942, 8250.510], [2000, 8639.465]],
                [[2000, 8639.465], [2000, 8000]],
                [[2000, 8000], [0, 8000]]
            ],

            [   // Flaggen-Positionen
                [1356, 7146.13, 0],
                [1877.28, 6242.87, 0]
            ],

            [   // Beam-Positionen
                [1920.97, 7109.31, 0],
                [813.783, 5812.49, 0]
            ]
        ],

        [    // Sektor 15
            [   // Sektormarker
                [[5188.556, 11000], [2000, 11000]],
                [[2000, 11000], [2000, 8639.465]],
                [[2000, 8639.465], [3616.942, 8250.510]],
                [[3616.942, 8250.510], [5112.762, 8218.190]],
                [[5112.762, 8218.190], [5616.570, 8205.931]],
                [[5616.570, 8205.931], [4629.017, 9541.081]],
                [[4629.017, 9541.081], [5188.556, 11000]]
            ],

            [   // Flaggen-Positionen
                [4107, 10442.5, 0],
                [2580.38, 8974.5, 0]
            ],

            [   // Beam-Positionen
                [4501.04, 9117.35, 0],
                [4321.88, 10636.2, 0]
            ]
        ],

        [    // Sektor 16
            [   // Sektormarker
                [[0, 14128.289], [0, 11000]],
                [[0, 11000], [2000, 11000]],
                [[2000, 11000], [5188.556, 11000]],
                [[5188.556, 11000], [5958.759, 11770.045]],
                [[5958.759, 11770.045], [0, 14128.289]]
            ],

            [   // Flaggen-Positionen
                [2119.25, 12714.6, 0],
                [4787.13, 11447.5, 0]
            ],

            [   // Beam-Positionen
                [966.564, 12660.9, 0],
                [3382.36, 12292.9, 0]
            ]
        ],

        [    // Sektor 17
            [   // Sektormarker
                [[0, 16056.343], [0, 14128.289]],
                [[0, 14128.289], [5958.759, 11770.045]],
                [[5958.759, 11770.045], [2909.158, 15590.489]],
                [[2909.158, 15590.489], [0, 16056.343]]
            ],

            [   // Flaggen-Positionen
                [1829.5, 14566.8, 0],
                [3678.37, 13845.2, 0]
            ],

            [   // Beam-Positionen
                [1519.45, 14299.3, 0],
                [3530.67, 13621.9, 0]
            ]
        ],

        [    // Sektor 18
            [   // Sektormarker
                [[5958.759, 11770.045], [8116.663, 13920.995]],
                [[8116.663, 13920.995], [5071.521, 14833.756]],
                [[5071.521, 14833.756], [5958.759, 11770.045]]
            ],

            [   // Flaggen-Positionen
                [6102.69, 12850.4, 0],
                [5958.34, 13702.1, 0]
            ],

            [   // Beam-Positionen
                [6132.85, 12882.9, 0],
                [6285.14, 14012.8, 0]
            ]
        ],

        [    // Sektor 19
            [   // Sektormarker
                [[8776.518, 12960.312], [9521.084, 13951.086]],
                [[9521.084, 13951.086], [8116.663, 13920.995]],
                [[8116.663, 13920.995], [5958.759, 11770.045]],
                [[5958.759, 11770.045], [7498.049, 11260.726]],
                [[7498.049, 11260.726], [8776.518, 12960.312]]
            ],

            [   // Flaggen-Positionen
                [8537.76, 13397.5, 0],
                [7100.92, 11966.6, 0]
            ],

            [   // Beam-Positionen
                [8327.27, 13136.4, 0],
                [6753.23, 11835, 0]
            ]
        ],

        [    // Sektor 20
            [   // Sektormarker
                [[10732.676, 14552.906], [9521.084, 13951.086]],
                [[9521.084, 13951.086], [8776.518, 12960.312]],
                [[8776.518, 12960.312], [12027.865, 12686.149]],
                [[12027.865, 12686.149], [13073.379, 13935.483]],
                [[13073.379, 13935.483], [10732.676, 14552.906]]
            ],

            [   // Flaggen-Positionen
                [10753.4, 13135.5, 0],
                [9731.6, 13369.3, 0]
            ],

            [   // Beam-Positionen
                [11785.6, 13479.1, 0],
                [9716.66, 13288.8, 0]
            ]
        ],

        [    // Sektor 21
            [   // Sektormarker
                [[14600, 9600], [14976.035, 11038.944]],
                [[14976.035, 11038.944], [13934.980, 13709.244]],
                [[13934.980, 13709.244], [13073.379, 13935.483]],
                [[13073.379, 13935.483], [12027.865, 12686.149]],
                [[12027.865, 12686.149], [11122.793, 11608.445]],
                [[11122.793, 11608.445], [14600, 9600]]
            ],

            [   // Flaggen-Positionen
                [13575.1, 12712.3, 0],
                [14386.3, 10342.8, 0]
            ],

            [   // Beam-Positionen
                [12963.8, 11049.5, 0],
                [14179, 12971.9, 0]
            ]
        ],

        [    // Sektor 22
            [   // Sektormarker
                [[14600, 9600], [11122.793, 11608.445]],
                [[11122.793, 11608.445], [10044.956, 11385.548]],
                [[10044.956, 11385.548], [9960.245, 10119.497]],
                [[9960.245, 10119.497], [11450.492, 8859.018]],
                [[11450.492, 8859.018], [14600, 9600]]
            ],

            [   // Flaggen-Positionen
                [11543.3, 10184, 0],
                [10752.3, 10970.1, 0]
            ],

            [   // Beam-Positionen
                [10630.8, 9895.6, 0],
                [12957.9, 9843.18, 0]
            ]
        ],

        [    // Sektor 23
            [   // Sektormarker
                [[14600, 7714.444], [14600, 9600]],
                [[14600, 9600], [11450.492, 8859.018]],
                [[11450.492, 8859.018], [13000.928, 7726.704]],
                [[13000.928, 7726.704], [14600, 7714.444]]
            ],

            [   // Flaggen-Positionen
                [12086.1, 8769.75, 0],
                [12936.4, 8312.31, 0]
            ],

            [   // Beam-Positionen
                [13271.4, 9069.05, 0],
                [13640.4, 7930.76, 0]
            ]
        ],

        [    // Sektor 24
            [   // Sektormarker
                [[11378.041, 6520.834], [12498.235, 5498.854]],
                [[12498.235, 5498.854], [13000.928, 7726.704]],
                [[13000.928, 7726.704], [11450.492, 8859.018]],
                [[11450.492, 8859.018], [9960.245, 10119.497]],
                [[9960.245, 10119.497], [9832.063, 7650.919]],
                [[9832.063, 7650.919], [11378.041, 6520.834]]
            ],

            [   // Flaggen-Positionen
                [12486, 7748.13, 0],
                [12453.1, 5913.88, 0]
            ],

            [   // Beam-Positionen
                [12259.8, 6762.45, 0],
                [10505.5, 8555.82, 0]
            ]
        ],

        [    // Sektor 25
            [   // Sektormarker
                [[8905.814, 4000], [11000, 4000]],
                [[11000, 4000], [11378.041, 6520.834]],
                [[11378.041, 6520.834], [9832.063, 7650.919]],
                [[9832.063, 7650.919], [8594.835, 7676.552]],
                [[8594.835, 7676.552], [8237.042, 5881.121]],
                [[8237.042, 5881.121], [8905.814, 4000]]
            ],

            [   // Flaggen-Positionen
                [9496.25, 6787.5, 0],
                [10544.1, 6595.88, 0]
            ],

            [   // Beam-Positionen
                [10002.6, 6240.45, 0],
                [10068.9, 4691.39, 0]
            ]
        ],

        [    // Sektor 26
            [   // Sektormarker
                [[5616.570, 8205.931], [5112.762, 8218.190]],
                [[5112.762, 8218.190], [5372.468, 6652.343]],
                [[5372.468, 6652.343], [5528.515, 5988.112]],
                [[5528.515, 5988.112], [7651.866, 4000]],
                [[7651.866, 4000], [8905.814, 4000]],
                [[8905.814, 4000], [8237.042, 5881.121]],
                [[8237.042, 5881.121], [8594.835, 7676.552]],
                [[8594.835, 7676.552], [7873.676, 8082.224]],
                [[7873.676, 8082.224], [5616.570, 8205.931]]
            ],

            [   // Flaggen-Positionen
                [6628.61, 5710.82, 0],
                [7090.57, 7097.21, 0]
            ],

            [   // Beam-Positionen
                [7682.2, 7320.42, 0],
                [7385.82, 4793.23, 0],
                [6163.15, 7037.3, 0]
            ]
        ],

        [    // Sektor 27
            [   // Sektormarker
                [[7498.049, 11260.726], [5958.759, 11770.045]],
                [[5958.759, 11770.045], [5188.556, 11000]],
                [[5188.556, 11000], [4629.017, 9541.081]],
                [[4629.017, 9541.081], [5616.570, 8205.931]],
                [[5616.570, 8205.931], [7873.676, 8082.224]],
                [[7873.676, 8082.224], [7724.317, 9330.443]],
                [[7724.317, 9330.443], [6699.981, 10178.564]],
                [[6699.981, 10178.564], [7498.049, 11260.726]]
            ],

            [   // Flaggen-Positionen
                [5222, 10013.1, 0],
                [5956.25, 9097, 0]
            ],

            [   // Beam-Positionen
                [6548.95, 8800.4, 0],
                [5650.42, 9824.81, 0],
                [6240.21, 10768, 0]
            ]
        ],

        [    // Sektor 28
            [   // Sektormarker
                [[12027.865, 12686.149], [8776.518, 12960.312]],
                [[8776.518, 12960.312], [7498.049, 11260.726]],
                [[7498.049, 11260.726], [9960.245, 10119.497]],
                [[9960.245, 10119.497], [10044.956, 11385.548]],
                [[10044.956, 11385.548], [11122.793, 11608.445]],
                [[11122.793, 11608.445], [12027.865, 12686.149]]
            ],

            [   // Flaggen-Positionen
                [8618.38, 11691, 0],
                [10042, 12417.5, 0]
            ],

            [   // Beam-Positionen
                [9126.35, 11231.5, 0],
                [9749.6, 12160.6, 0],
                [10769.1, 12086.3, 0]
            ]
        ],

        [    // Sektor 29
            [   // Sektormarker
                [[9960.245, 10119.497], [7498.049, 11260.726]],
                [[7498.049, 11260.726], [6699.981, 10178.564]],
                [[6699.981, 10178.564], [7724.317, 9330.443]],
                [[7724.317, 9330.443], [9960.245, 10119.497]]
            ],

            [   // Flaggen-Positionen
                [8307.75, 10460.9, 0],
                [7176.88, 10171.9, 0]
            ],

            [   // Beam-Positionen
                [8680.84, 10170.2, 0],
                [7584.55, 10215.9, 0]
            ]
        ],

        [    // Sektor 30
            [   // Sektormarker
                [[9832.063, 7650.919], [9960.245, 10119.497]],
                [[9960.245, 10119.497], [7724.317, 9330.443]],
                [[7724.317, 9330.443], [7873.676, 8082.224]],
                [[7873.676, 8082.224], [8594.835, 7676.552]],
                [[8594.835, 7676.552], [9832.063, 7650.919]]
            ],

            [   // Flaggen-Positionen
                [9375.88, 7966.13, 0],
                [8364.75, 8961.25, 0]
            ],

            [   // Beam-Positionen
                 [9462.97, 9031.72, 0],
                 [8776.36, 8148.44, 0]
            ]
        ]
    ]; // letztes Komma löschen!!
};

if (worldName == "cup_chernarus_A3") then
{
    GVAR(AllSectors) =
    [
        [    // Sektor 0
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
            ],

            [   // Beam-Positionen
            ]
        ],

        [    // Sektor 1
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
                [1876.93,2255.05,0]
            ],

            [   // Beam-Positionen
                [1918.55,4316.99,0] // nord
            ]
        ],

        [    // Sektor 2
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
            ],

            [   // Beam-Positionen
                [4077.33,2612.46,0] // ost
            ]
        ]
    ]; // letztes Komma löschen!!
};

if (worldName == "pja310") then // rajak
{
    GVAR(AllSectors) =
    [
        [    // Sektor 0
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
            ],

            [   // Beam-Positionen
            ]
        ],

        [    // Sektor 1
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
                [16505.7,19150.7,0]
            ],

            [   // Beam-Positionen
                [18183.2,17543.4,0] // süd
            ]
        ],

        [    // Sektor 2
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
            ],

            [   // Beam-Positionen
                [13913.4,19464,0]   // west
            ]
        ]
    ]; // letztes Komma löschen!!
};

if (worldName == "tem_kujari") then
{
    GVAR(AllSectors) =
    [
        [    // Sektor 0
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
            ],

            [   // Beam-Positionen
            ]
        ],

        [    // Sektor 1
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
                [14806.8,5804.92,0]
            ],

            [   // Beam-Positionen
                [16007,3003.46,0]   // süd
            ]
        ],

        [    // Sektor 2
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
            ],

            [   // Beam-Positionen
                [13980.3,9008.8,0]  // nord
            ]
        ]
    ]; // letztes Komma löschen!!
};

if (worldName == "gm_weferlingen_summer") then
{
    GVAR(AllSectors) =
    [
        [    // Sektor 0
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
            ],

            [   // Beam-Positionen
            ]
        ],

        [    // Sektor 1
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
                [19680.3,8428.14,0]
            ],

            [   // Beam-Positionen
                [19926.5,4774.59,0] // süd
            ]
        ],

        [    // Sektor 2
            [   // Sektormarker
            ],

            [   // Flaggen-Positionen
            ],

            [   // Beam-Positionen
                [19543,11527.1,0]   // nord
            ]
        ]
    ]; // letztes Komma löschen!!
};

publicVariable QGVAR(AllSectors);

// Create MineZoneMarker for all possible flags (will be deleted after Waffenruhe)
GVAR(PreMineZoneMarkers) = [];
private _PreMineZoneMarkerID = 0;
if (isServer && GVAR(flagFreeMineZoneMarkerOn)) then
{
    {
        {
            _PreMineZoneMarkerID = _PreMineZoneMarkerID + 1;
            private _markerName = format["PreMineZoneMarker_%1", _PreMineZoneMarkerID];
            private _marker = createMarkerLocal [_markerName, _x];
            GVAR(PreMineZoneMarkers) pushBack _marker;
            _marker setMarkerShapeLocal "ELLIPSE";
            _marker setMarkerBrushLocal "Solid";
            _marker setMarkerColorLocal "ColorRed";
            _marker setMarkerAlphaLocal 0.5;
            _marker setMarkerSize [GVAR(flagFreeMineZoneRadius), GVAR(flagFreeMineZoneRadius)];
        } forEach (_x select 1); // all flags
    } forEach GVAR(AllSectors); // all sectors
};
publicVariable QGVAR(PreMineZoneMarkers);

// Sector-Markers
GVAR(NATOSectorMarkers) = [];
GVAR(CSATSectorMarkers) = [];
GVAR(BorderMarkers) = [];
private _markerID = 0;

// CBA-Settings parsen, da dies sonst erst nach dem "Durchdrücken" geschieht
GVAR(nato_allsectors) = parseSimpleArray format ["[%1]", GVAR(nato_allsectors_str)];
GVAR(csat_allsectors) = parseSimpleArray format ["[%1]", GVAR(csat_allsectors_str)];

// Sektormarker zeichnen
{
    {
        _markerID = _markerID + 1;
        private _markername = format ["SectorMarker_%1", _markerID];
        [_x, "ColorBlack", 8, _markername] call FUNC(drawline);
        GVAR(NATOSectorMarkers) pushBack _markername;
    } forEach ((GVAR(AllSectors) select _x) select 0);
} forEach GVAR(nato_allsectors);

{
    {
        _markerID = _markerID + 1;
        private _markername = format ["SectorMarker_%1", _markerID];
        [_x, "ColorBlack", 8, _markername] call FUNC(drawline);
        GVAR(CSATSectorMarkers) pushBack _markername;
    } forEach ((GVAR(AllSectors) select _x) select 0);
} forEach GVAR(csat_allsectors);

// Grenzlinien
// Wenn sich zwei feindliche Sektormarker-Linien sehr nah sind -> Grenzlinie dazwischen zeichnen
{
    private _pos1 = getMarkerPos _x;
    {
        private _pos2 = getMarkerPos _x;
        if ((_pos1 distance2D _pos2) < 50) then
        {
            private _grenzlinie = (_pos1 vectorAdd _pos2) vectorMultiply 0.5;   // Position zwischen den beiden betroffenen Markern
            _markerID = _markerID + 1;
            private _markername = format ["BorderMarker_%1", _markerID];
            GVAR(BorderMarkers) pushBack _markername;

            private _mrk = createMarkerLocal [_markername, _grenzlinie];
            _mrk setMarkerDirLocal markerDir _x;
            _mrk setMarkerShapeLocal "RECTANGLE";
            _mrk setMarkerBrushLocal "SolidFull";
            _mrk setMarkerColorLocal "ColorRed";
            _mrk setMarkerSize [10, (markerSize _x) select 1];   // Letzter Markerbefehl nicht-local (für serverweiten Broadcast)
        };
    } forEach GVAR(CSATSectorMarkers)
} forEach GVAR(NATOSectorMarkers);

// Karten Umrandung
//private _worldsize = (worldName call BIS_fnc_mapSize);
//[[[0, _worldsize], [_worldsize, _worldsize]], "ColorRed", 24, "MapBorder1"] call FUNC(drawline);
//[[[_worldsize, _worldsize], [_worldsize, 0]], "ColorRed", 24, "MapBorder2"] call FUNC(drawline);
//[[[_worldsize, 0], [0, 0]], "ColorRed", 24, "MapBorder3"] call FUNC(drawline);
//[[[0, 0], [0, _worldsize]], "ColorRed", 24, "MapBorder4"] call FUNC(drawline);

// Karten Umrandung
[[[0, worldSize], [worldSize, worldSize]], "ColorRed", 24, "MapBorder1"] call FUNC(drawline);
[[[worldSize, worldSize], [worldSize, 0]], "ColorRed", 24, "MapBorder2"] call FUNC(drawline);
[[[worldSize, 0], [0, 0]], "ColorRed", 24, "MapBorder3"] call FUNC(drawline);
[[[0, 0], [0, worldSize]], "ColorRed", 24, "MapBorder4"] call FUNC(drawline);
