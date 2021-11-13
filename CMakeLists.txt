cmake_minimum_required(VERSION 3.0.2)
project(valkyrieus)

find_package(catkin REQUIRED COMPONENTS
    val_viz
    roseus
)

add_custom_command(OUTPUT ${PROJECT_SOURCE_DIR}/robots/valkyrie.l
    COMMAND rosrun euscollada collada2eus valkyrie.dae valkyrie.yaml valkyrie.l
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/robots
    DEPENDS ${PROJECT_SOURCE_DIR}/robots/valkyrie.dae ${PROJECT_SOURCE_DIR}/robots/valkyrie.yaml)
add_custom_command(OUTPUT ${PROJECT_SOURCE_DIR}/robots/valkyrie.dae
    COMMAND rosrun collada_urdf urdf_to_collada ${val_viz_SOURCE_PREFIX}/robot_urdf/valkyrie_sim_gazebo_sync.urdf valkyrie.dae
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/robots
    DEPENDS ${val_viz_SOURCE_PREFIX}/robot_urdf/valkyrie_sim_gazebo_sync.urdf)

find_package(PkgConfig)
pkg_check_modules(COLLADA collada-dom>=2.4.4)
if(${COLLADA_FOUND})
  add_custom_target(generate_valkyrie_sim_gazebo_sync_lisp ALL DEPENDS ${PROJECT_SOURCE_DIR}/robots/valkyrie.l)
  # add_custom_target(generate_valkyrie_sim_gazebo_sync_lisp ALL DEPENDS ${PROJECT_SOURCE_DIR}/robots/valkyrie.dae)
else()
  pkg_check_modules(COLLADA collada-dom)
  message(WARNING "urdf_to_collada requries collada-dom >= 2.4.4, installed version is ${COLLADA_VERSION}")
endif()

catkin_package()
