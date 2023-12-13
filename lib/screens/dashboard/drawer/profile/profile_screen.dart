import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wehealth/controller/auth_controller/auth_controller.dart';
import 'package:wehealth/controller/body_measurement_controller/body_measurement_controller.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/global/styles/button_style.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/profile_model.dart';
import 'package:wehealth/models/data_model/update_profile_model.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';
import 'package:wehealth/screens/dashboard/notifications/notification_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import 'package:wehealth/screens/dashboard/widgets/scrolling_date_picker.dart';
import '../../../../global/constants/color_resources.dart';
import '../../../../global/styles/text_field_decoration.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  // TextEditingController nricCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController postalCon = TextEditingController();
  TextEditingController cityCon = TextEditingController();
  TextEditingController stateCon = TextEditingController();
  TextEditingController dobCon = TextEditingController();
  TextEditingController weightCon = TextEditingController();
  TextEditingController heightCon = TextEditingController();
  TextEditingController icCon = TextEditingController();
  TextEditingController mrnCon = TextEditingController();

  // All the options
  List<String> countries = [
    "Malaysia",
    "Afghanistan",
    "Albania",
    "Algeria",
    "American Samoa",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antarctica",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegowina",
    "Botswana",
    "Bouvet Island",
    "Brazil",
    "British Indian Ocean Territory",
    "Brunei Darussalam",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Cayman Islands",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Christmas Island",
    "Cocos (Keeling) Islands",
    "Colombia",
    "Comoros",
    "Congo",
    "Congo, the Democratic Republic of the",
    "Cook Islands",
    "Costa Rica",
    "Cote d'Ivoire",
    "Croatia (Hrvatska)",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "East Timor",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Ethiopia",
    "Falkland Islands (Malvinas)",
    "Faroe Islands",
    "Fiji",
    "Finland",
    "France",
    "France Metropolitan",
    "French Guiana",
    "French Polynesia",
    "French Southern Territories",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Gibraltar",
    "Greece",
    "Greenland",
    "Grenada",
    "Guadeloupe",
    "Guam",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Heard and Mc Donald Islands",
    "Holy See (Vatican City State)",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran (Islamic Republic of)",
    "Iraq",
    "Ireland",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea, Democratic People's Republic of",
    "Korea, Republic of",
    "Kuwait",
    "Kyrgyzstan",
    "Lao, People's Democratic Republic",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libyan Arab Jamahiriya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macau",
    "Macedonia, The Former Yugoslav Republic of",
    "Madagascar",
    "Malawi",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Martinique",
    "Mauritania",
    "Mauritius",
    "Mayotte",
    "Mexico",
    "Micronesia, Federated States of",
    "Moldova, Republic of",
    "Monaco",
    "Mongolia",
    "Montserrat",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "Netherlands Antilles",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Niue",
    "Norfolk Island",
    "Northern Mariana Islands",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Pitcairn",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Reunion",
    "Romania",
    "Russian Federation",
    "Rwanda",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia (Slovak Republic)",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Georgia and the South Sandwich Islands",
    "Spain",
    "Sri Lanka",
    "St. Helena",
    "St. Pierre and Miquelon",
    "Sudan",
    "Suriname",
    "Svalbard and Jan Mayen Islands",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syrian Arab Republic",
    "Taiwan, Province of China",
    "Tajikistan",
    "Tanzania, United Republic of",
    "Thailand",
    "Togo",
    "Tokelau",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Turks and Caicos Islands",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "United States Minor Outlying Islands",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Venezuela",
    "Vietnam",
    "Virgin Islands (British)",
    "Virgin Islands (U.S.)",
    "Wallis and Futuna Islands",
    "Western Sahara",
    "Yemen",
    "Yugoslavia",
    "Zambia",
    "Zimbabwe",
    "Palestine"
  ];
  List<String> maritalStatus = ['Single', 'Married', 'Divorced'];
  List<String> race = ['Indian', 'Chinese', 'Bumiputera', 'Other'];
  List<String> education = [
    'No formal schooling',
    'Less than primary school',
    'Primary school completed',
    'Secondary/high school completed',
    'College/university completed',
  ];
  List<String> stateList = [
    'Kuala Lumpur',
    'Johor',
    'Kedah',
    'Kelantan',
    'Labuan',
    'Melaka',
    'Negeri Sembilan',
    'Pahang',
    'Perak',
    'Perlis',
    'Pulau Pinang',
    'Putrajaya',
    'Sabah',
    'Sarawak',
    'Selangor',
    'Terengganu',
    'Wilayah Persekutuan',
  ];
  List<String> lifeStyle = [
    'Sedentary',
    'Lightly Active',
    'Moderate Active',
    'Very active',
    'Extra Active',
  ];
  List<String> interest = [
    'Be more active',
    "Eat healthier",
    "Healthy weight management",
    "Maintain overall health",
    "Monitor my Hypertension",
    "Manage my Diabetes",
    "Remote health monitor my family members",
    "MyHealth",
  ];
  List<String> hospital = [
    'Yes',
    "No",
  ];
  List<String> genderValue = [
    'Male',
    "Female",
    "Other",
  ];

// All the values
  String? country;
  String? interestValue = 'Be more active';
  String? lifeStyleValue = 'Moderate Active';
  String? hospitalValue = 'No';
  String? gender;
  String? smokeValue = "No";
  String? profilePic;
  String? stateValue = 'Johor';
  String? educationValue = 'College/university completed';
  String? maritalValue = 'Single';
  String? raceValue = 'Chinese';
  String? selectedHospital = "Select a hospital";
  bool isVarified = false;

  String? finalDOB;

  @override
  void initState() {
    super.initState();
    initializer();
  }

  // final DateFormat birthdateFormat = DateFormat("YYYY-MM-dd");

  initializer() {
    // Get.find<ProfileController>().addListenerId("initialization", () {});

    ProfileController controller = Get.find<ProfileController>();
    if (controller.userProfile.userID != null) {
      UserProfile profile = controller.userProfile;
      log("profile = ${profile.firstName}");
      firstNameCon.text = profile.firstName ?? "";
      lastNameCon.text = profile.lastName ?? "";
      emailCon.text = profile.email ?? "";
      phoneCon.text = profile.phone ?? "";
      icCon.text = profile.icNumber ?? "";
      addressCon.text = profile.address ?? "";
      postalCon.text = profile.postCode ?? "";
      stateValue = profile.state;
      cityCon.text = profile.town ?? "";
      heightCon.text = double.tryParse(profile.height ?? "")?.toInt().toString() ?? "";
      weightCon.text = profile.weight ?? "";
      educationValue = profile.eduction;
      gender = profile.gender;
      country = profile.country;
      maritalValue = profile.marital;
      raceValue = profile.race;
      // lifeStyleValue = profile.li
      log("BirthDate => ${profile.birthDate}");
      interestValue = profile.cardName;
      lifeStyleValue = profile.lifestyle;
      smokeValue = profile.smoking;
      profilePic = profile.profilepic;

      dobCon.text = (profile.birthDate == "0000-00-00")
          ? ""
          : DateFormat("dd-MM-yyyy")
              .format(stringDateWithTZ.parse(profile.birthDate ?? ""));
      finalDOB = (profile.birthDate == "0000-00-00")
          ? ""
          : DateFormat("yyyy-MM-dd")
              .format(stringDateWithTZ.parse(profile.birthDate ?? ""));

      isVarified = profile.loginType != "0" && profile.loginType != "";
      if (isVarified) {
        hospitalValue = "Yes";
        selectedHospital =
            controller.getSelectedHospital?.name ?? "Select a hospital";
        icCon.text = profile.icNumber ?? "";
        mrnCon.text = controller.userHospitalRelation?.refID ?? "";
      }
    } else {
      log("User profile null");
    }
  }

  saveFile(XFile image) async {
    File imageFile = File(image.path);
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/${image.name}';
    log(filePath);
    await imageFile.copy(filePath);

    Get.find<StorageController>().setProfileImgPath(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              Get.to(() => const NotificationScreen());
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),

      drawer: const DrawerSide(),
      //drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
      body: GetBuilder<ProfileController>(builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async =>
                    await controller.getUserProfile(ignoreLocal: true),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 18),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      controller.userProfile.username ??
                                          Get.find<AuthController>()
                                              .user
                                              ?.username ??
                                          "example@gmail.com",
                                      style: TextStyles.normalTextBoldStyle()
                                          .copyWith(color: Colors.blue),
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      height: 120.h,
                                      child: GestureDetector(
                                        onTap: () async {
                                          final file =
                                              await fetchImage(context);
                                          if (file != null) saveFile(file);
                                          // showDialog(context: context, builder: builder)
                                        },
                                        child: controller.userProfile
                                                        .profilepic !=
                                                    null ||
                                                controller.userProfile
                                                        .profilepic !=
                                                    "null"
                                            ? Image.network(
                                                "https://www.umchtech.com/chief/portal/uploads/${controller.userProfile.profilepic}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                //log(error.toString());
                                                return Image.asset(
                                                  (controller.userProfile
                                                              .gender ==
                                                          "Male"
                                                      ? "assets/images/male_profile.jpeg"
                                                      : "assets/images/female_profile.jpeg"),
                                                );
                                              }, loadingBuilder: (context,
                                                    child, loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child: SizedBox.square(
                                                    dimension: 40,
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: (loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!) *
                                                          100,
                                                    ),
                                                  ),
                                                );
                                              })
                                            : const SizedBox(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // TextField
                          Text(
                            'First Name*',
                            style: TextStyles.extraSmallTextStyle().copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: firstNameCon,
                            decoration:
                                decoration.copyWith(hintText: "First name"),
                            validator: (value) {
                              return (value != "")
                                  ? null
                                  : "First name is compulsory!";
                            },
                          ),
                          SizedBox(height: 12.h),
                          // TextField
                          Text(
                            'Last Name',
                            style: TextStyles.extraSmallTextStyle().copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: lastNameCon,
                            decoration:
                                decoration.copyWith(hintText: "Last name"),
                          ),
                          SizedBox(height: 12.h),
                          // TextField
                          Text(
                            'Email*',
                            style: TextStyles.extraSmallTextStyle().copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: emailCon,
                            decoration: decoration,
                            validator: (value) {
                              return (value != null &&
                                      value.isNotEmpty &&
                                      value.contains("@") &&
                                      value.contains("."))
                                  ? null
                                  : "Email name is compulsory!";
                            },
                          ),
                          SizedBox(height: 12.h),
                          // TextField
                          Text(
                            'Phone',
                            style: TextStyles.extraSmallTextStyle().copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: phoneCon,
                            decoration:
                                decoration.copyWith(hintText: "601XXXXXXXXX"),
                          ),
                          SizedBox(height: 12.h),
                          // TextField
                          Text(
                            'NRIC or Passport Number',
                            style: TextStyles.extraSmallTextStyle().copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: /* nricCon */ icCon,
                            decoration:
                                decoration.copyWith(hintText: "990912025545"),
                          ),
                          SizedBox(height: 12.h),
                          // TextField
                          Text(
                            'Address',
                            style: TextStyles.extraSmallTextStyle().copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: addressCon,
                            decoration: decoration.copyWith(
                                hintText: "No 81, Jalan SS6"),
                          ),
                          SizedBox(height: 12.h),
                          //Row text double field
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Postal/Zip Code',
                                      maxLines: 1,
                                      style: TextStyles.extraSmallTextStyle()
                                          .copyWith(
                                              color: Colors.grey.shade800,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      textCapitalization:
                                          TextCapitalization.none,
                                      controller: postalCon,
                                      decoration: decoration.copyWith(
                                          hintText: "47300"),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.h),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'City/Town',
                                      style: TextStyles.extraSmallTextStyle()
                                          .copyWith(
                                              color: Colors.grey.shade800,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      textCapitalization:
                                          TextCapitalization.none,
                                      controller: cityCon,
                                      decoration: decoration.copyWith(
                                          hintText: "Petaling Jaya"),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          //Row text double field
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'State',
                                      style: TextStyles.extraSmallTextStyle()
                                          .copyWith(
                                              color: Colors.grey.shade800,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      height: 60.h,
                                      child: ProfileDropDown(
                                        value: stateValue,
                                        items: stateList,
                                        onChanged: (value) {
                                          setState(() {
                                            stateValue = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.h),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Country/Region',
                                      maxLines: 1,
                                      style: TextStyles.extraSmallTextStyle()
                                          .copyWith(
                                              color: Colors.grey.shade800,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      height: 60.h,
                                      child: ProfileDropDown(
                                        value: country,
                                        items: countries,
                                        onChanged: (value) {
                                          setState(() {
                                            country = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          //Gender Selector with image
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender*',
                                style: TextStyles.extraSmallTextStyle()
                                    .copyWith(
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 60.h,
                                child: ProfileDropDown(
                                  value: gender,
                                  items: genderValue,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),

                          // TextField
                          Text(
                            'Date of Birth*',
                            style: TextStyles.extraSmallTextStyle().copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () async {
                              DateTime? date = await showPackageScrollingPicker(
                                context,
                                DateFormat("dd-MM-yyyy").parse(
                                  (dobCon.text == "")
                                      ? "01-01-1900"
                                      : dobCon.text,
                                ),
                              );
                              log(date.toString());
                              if (date != null) {
                                log("Selected Date ${date.toString()}");
                                setState(() {
                                  dobCon.text =
                                      DateFormat("dd-MM-yyyy").format(date);
                                  log("mukta @ dob now ===>> ${dobCon.text}");

                                  finalDOB =
                                      DateFormat("yyyy-MM-dd").format(date);
                                  log("mukta @ ===>> sending to db || $finalDOB");
                                });
                              }
                            },
                            child: AbsorbPointer(
                              absorbing: true,
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: dobCon,
                                validator: (value) {
                                  return (value != "")
                                      ? null
                                      : "Date of Birth is compulsory!";
                                },
                                decoration: decoration.copyWith(
                                  hintText: "DD-MM-YYYY",
                                  suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.calendar_month,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: TextFormField(
                              controller: weightCon,
                              decoration: decoration.copyWith(
                                suffixIcon: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('kg'),
                                  ],
                                ),
                              ),
                            ),
                            value: false,
                            onChanged: (value) {},
                          ),
                          SizedBox(height: 12.h),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: TextFormField(
                              controller: heightCon,
                              decoration: decoration.copyWith(
                                suffixIcon: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('cm'),
                                  ],
                                ),
                              ),
                            ),
                            value: false,
                            onChanged: (value) {},
                          ),
                          SizedBox(height: 12.h),
                          // Yes/No question
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Are you a smoker?',
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                  style: TextStyles.customText(
                                          13.sp, FontWeight.w600)
                                      .copyWith(color: Colors.grey.shade800),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                    visualDensity: VisualDensity.compact,
                                    value: "Yes",
                                    groupValue: smokeValue,
                                    onChanged: (value) {
                                      setState(() {
                                        smokeValue = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Yes',
                                    style: TextStyles.extraSmallTextStyle()
                                        .copyWith(
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w600)
                                        .copyWith(
                                            color: ColorResources.colorGray),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Radio<String>(
                                    visualDensity: VisualDensity.compact,
                                    value: "No",
                                    groupValue: smokeValue,
                                    onChanged: (value) {
                                      setState(() {
                                        smokeValue = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'No',
                                    style: TextStyles.extraSmallTextStyle()
                                        .copyWith(
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w600)
                                        .copyWith(
                                            color: ColorResources.colorGray),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Dropdown questions
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Marital Status",
                                  style: TextStyles.extraSmallTextStyle()
                                      .copyWith(
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SizedBox(
                                  height: 60.h,
                                  child: ProfileDropDown(
                                    value: maritalValue,
                                    items: maritalStatus,
                                    onChanged: (value) {
                                      setState(() {
                                        maritalValue = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Race",
                                  style: TextStyles.extraSmallTextStyle()
                                      .copyWith(
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SizedBox(
                                  height: 60.h,
                                  child: ProfileDropDown(
                                    value: raceValue,
                                    items: race,
                                    onChanged: (value) {
                                      setState(() {
                                        raceValue = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Education Level",
                                  style: TextStyles.extraSmallTextStyle()
                                      .copyWith(
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SizedBox(
                                  height: 60.h,
                                  child: ProfileDropDown(
                                    value: educationValue,
                                    items: education,
                                    onChanged: (value) {
                                      setState(() {
                                        educationValue = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "What is your current lifestyle?",
                            style: TextStyles.extraSmallTextStyle().copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 60.h,
                            child: ProfileDropDown(
                              value: lifeStyleValue,
                              items: lifeStyle,
                              onChanged: (value) {
                                setState(() {
                                  lifeStyleValue = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "What are you interested in?",
                            style: TextStyles.extraSmallTextStyle().copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 60.h,
                            child: ProfileDropDown(
                              value: interestValue,
                              items: interest,
                              onChanged: (value) {
                                setState(() {
                                  interestValue = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50.h,
                    child: TextButton(
                      style: ButtonStyles.getBlueStyle(context).copyWith(
                        shape: const MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        // setState(() {
                        if (gender!.isEmpty ||
                            gender == null ||
                            gender == "Select") {
                          showToast("Gender is required to select!", context);
                          log("getting null 1");
                        } else {
                          if (formKey.currentState!.validate()) {
                            final newProfile = UpdateProfileModel(
                              address: addressCon.text,
                              age: controller.userProfile.age,
                              birthDate: finalDOB.toString(),
                              //birthDate: dobCon.text,

                              cardname: interestValue,
                              country: country,
                              education: educationValue,
                              email: emailCon.text,
                              firstName: firstNameCon.text,
                              lastName: lastNameCon.text,
                              gender: gender,
                              height: heightCon.text,
                              icNumber: icCon.text,
                              imagePath: controller.userProfile.profilepic,
                              isActive: 1,
                              isMonash: 0,
                              lifestyle: lifeStyleValue,
                              loginType: int.tryParse(
                                  controller.userProfile.loginType ?? "0"),
                              marital: maritalValue,
                              phone: phoneCon.text,
                              postCode: postalCon.text,
                              
                              questionnaire:
                                  controller.userProfile.questionnaire,
                              race: raceValue,
                              smoking: smokeValue,
                              state: stateValue,
                              stride: "",
                              town: cityCon.text,
                              username: controller.userProfile.username,
                              usertype: 1,
                              weight: weightCon.text,
                            );

                            Get.showOverlay(
                              loadingWidget: const OverlayLoadingIndicator(),
                              asyncFunction: () async {
                                final oldheight = double.tryParse(
                                    controller.userProfile.height ?? "");
                                final oldWeight = double.tryParse(
                                    controller.userProfile.weight ?? "");
                                final weight = double.tryParse(weightCon.text);
                                final height = double.tryParse(heightCon.text);
                                if ((height != null && height != oldheight) ||
                                    (weight != null && weight != oldWeight)) {
                                  await Get.find<BodyMeasurementController>()
                                      .addUserBodyWeight(
                                    weightQty: weight!,
                                    height: height!,
                                    time: DateTime.now(),
                                  );
                                }
                                await controller.updateUserData(newProfile);
                              },
                            );
                          }
                        }
                        // });
                      },
                      child: Text(
                        "Save",
                        style: TextStyles.extraSmallTextStyle()
                            .copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600)
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}

class ProfileDropDown extends StatelessWidget {
  ProfileDropDown({
    Key? key,
    required String? value,
    required this.items,
    required this.onChanged,
  })  : _value = (value == null || value == "" || value == "null")
            ? "Select"
            : value,
        super(key: key) {
    if (!items.contains(_value)) {
      items.add(_value);
    }
  }

  final String _value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: decoration,
      value: _value,
      style: TextStyles.customText(12.sp, FontWeight.w600)
          .copyWith(color: Colors.grey.shade800),
      alignment: Alignment.center,
      items: items
          .map(
            (value) => DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.toString(),
                style: TextStyles.extraSmallDaysTextStyle(),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
