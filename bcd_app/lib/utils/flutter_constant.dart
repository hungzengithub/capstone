import 'package:flutter/material.dart';

const Color DEFAULT_COLOR = Color.fromRGBO(72, 154, 150, 1);
const Color DEFAULT_COLOR_2 = Color.fromRGBO(192, 242, 239, 1);
const Color DEFAULT_COLOR_3 = Color.fromRGBO(139, 231, 226, 1);

// const Color BOTTOM_NAV_COLOR = Color(0xff7fb4fa);
const Color BOTTOM_NAV_COLOR = Color(0xff3d8ffc);

const Color ILLUSTRATION_PINK_COLOR = Color(0xfff68c82);
const Color ILLUSTRATION_BLUE_COLOR = Color(0xff7fb4fa);
const Color ILLUSTRATION_BLUE_COLOR_2 = Color(0xff68a4fc);
const Color ILLUSTRATION_BLUE_COLOR_DRAWER = Color(0xff007dfe);
const Color ILLUSTRATION_BLUE_COLOR_LOGIN = Color(0xffe5f0fe);
const Color ILLUSTRATION_GREY_HIGH_COLOR = Color(0xff959eaa);
const Color ILLUSTRATION_GREY_LIGHT_COLOR = Color(0xffe5e9ef);

const Color ILLUSTRATION_ORANGE_COLOR_FORGOTPASS = Color(0xfff48672);

const Color SCHEDULED_COLOR = Color.fromRGBO(114, 171, 228, 1);
const Color UNSCHEDULED_COLOR = Color.fromRGBO(179, 166, 160, 1);
//const Color FIXED_COLOR = Colors.green[600];

const Color DARK_TEXT_COLOR_1 = Color.fromRGBO(32, 49, 82, 1);

const Color BOTTOM_NAVI_ACTIVE_COLOR = Color.fromRGBO(72, 155, 255, 1);
const Color BOTTOM_NAVI_INACTIVE_COLOR = Color.fromRGBO(72, 155, 255, 1);

const Pattern PASSWORD_PATTERN = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{7,})';

//API

const String BASE_URL = "https://bcdsys.azurewebsites.net/api/v1/";
//const String BASE_URL = "https://localhost:5001/api/v1/";

// CRACK URL
const String CRACK_URL = BASE_URL + "cracks";
const String CRACK_URL_BY_STATUS = CRACK_URL + "?status=";

//MAINTAINANCE URL

const String MAINTAINANCE_URL = BASE_URL + "maintenance-orders";
const String CONFIRM_MAINTAINANCE_URL = MAINTAINANCE_URL + "/confirm";

//QUEUE URL

const String QUEUE_URL = MAINTAINANCE_URL + "/queue";

//NOTIFICATION_URL

const String NOTIFICATION_URL = BASE_URL + "notifications";

//USER URL
const String USER_URL = BASE_URL + "users/";
const String LOGIN_STAFF = USER_URL + "authenticate/staff";

const String FORGOT_PASS_URL = USER_URL + "forgotpass-confirm-m?username=";

//WORKER_URL
const String MAINTAINANCE_WORKER_URL = BASE_URL + "maintenance-workers";
