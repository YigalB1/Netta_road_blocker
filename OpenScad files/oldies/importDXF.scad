//path = "C:/Users/NH5\Documents\Projects\VSCODE projects\Netta_road_blocker\OpenScad files\";


//linear_extrude(height = 10, center = true, convexity = 10, twist = 0) import_dxf(file="c://Users//NH5//Documents//Projects//VSCODE projects//Netta_road_blocker//openScad files//PCB_Netta_games_2021-11-12.dxf" , layer = "0")  ;

linear_extrude(height = 10, center = true, convexity = 10, twist = 0) import(file="PCB_Netta_games_2021-11-12.dxf" , layer = "all")  ;