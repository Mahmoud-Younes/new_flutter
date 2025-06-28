class Station {
  final String station_name;
  final double latitude;
  final double longtitude;

  Station({
    required this.station_name,
    required this.latitude,
    required this.longtitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'station_name': station_name,
      'latitude': latitude,
      'longtitude': longtitude,
    };
  }
}

class Transport {
  final String id;
  final String Title;
  final String subtitle;
  final String price;
  final List<Station> station;
  final List<String> images;

  Transport({
    required this.id,
    required this.Title,
    required this.subtitle,
    required this.price,
    required this.station,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Title': Title,
      'subtitle': subtitle,
      'price': price,
      'station': station.map((x) => x.toMap()).toList(),
      'images': images,
    };
  }
}

List<Transport> transport = [
  Transport(
    id: "1",
    Title: "Bus",
    subtitle: "Bus services offering routes across major cities and towns",
    price: "15",
    station: [
      Station(
        station_name: "Mwasalat Misr",
        latitude: 30.1096,
        longtitude: 31.34842,
      ),
      Station(
        station_name: "Mwaslat Misr 6th of October",
        latitude: 30.0,
        longtitude: 30.96256,
      ),
      Station(
        station_name: "GoMini",
        latitude: 30.063,
        longtitude: 31.23343,
      ),
      Station(
        station_name: "AlAsssima Station",
        latitude: 30.0363,
        longtitude: 31.20184,
      ),
      Station(
        station_name: "Elmonib minibus",
        latitude: 30.0042,
        longtitude: 31.21283,
      ),
      Station(
        station_name: "Helwan Bus Station",
        latitude: 29.8832,
        longtitude: 31.3214,
      ),
    ],
    images: [
      'https://www.propertyfinder.eg/blog/wp-content/uploads/2024/12/%D9%85%D9%88%D8%A2%D9%85%D8%B5%D8%B1-1-800x450.jpg',
      'https://autozone-mag.com/storage/posts/1789-%D8%A7%D9%84%D8%A7%D9%88%D8%A8%D9%8A%D8%B3%20%D8%A7%D9%84%D9%83%D9%87%D8%B1%D8%A8%D8%A7%D8%A6%D9%8A%201.jpeg',
      'https://assets.cairo360.com/app/uploads/2018/11/19577212_826619897523949_1907718244824641748_o-1024x683.jpg'
    ],
  ),
  Transport(
    id: "2",
    Title: "Train",
    subtitle: "Bus services offering routes across major cities and towns",
    price: "150",
    station: [
      Station(
        station_name: "Ramsis Station",
        latitude: 30.07435,
        longtitude: 31.24643,
      ),
      Station(
        station_name: "Giza Station",
        latitude: 30.0,
        longtitude: 31.20711,
      ),
      Station(
        station_name: "Suez Station",
        latitude: 30.03164,
        longtitude: 31.32303,
      ),
      Station(
        station_name: "Zawya Hamra Station",
        latitude: 30.02713,
        longtitude: 31.37923,
      ),
      Station(
        station_name: "Bashtil Station",
        latitude: 30.10189,
        longtitude: 31.18044,
      ),
      Station(
        station_name: "Burtus Railway",
        latitude: 30.1613,
        longtitude: 31.1513,
      ),
      Station(
        station_name: "Al Khanka Station",
        latitude: 30.23776,
        longtitude: 31.36674,
      ),
      Station(
        station_name: "Benha Station",
        latitude: 30.48426,
        longtitude: 31.18823,
      ),
      Station(
        station_name: "Menouf Station",
        latitude: 30.48071,
        longtitude: 30.93691,
      ),
      Station(
        station_name: "Shebin Station",
        latitude: 30.58672,
        longtitude: 31.01329,
      ),
      Station(
        station_name: "Zagzig Station",
        latitude: 30.59972,
        longtitude: 31.50218,
      ),
      Station(
        station_name: "Tanta Station",
        latitude: 30.79811,
        longtitude: 30.99681,
      ),
      Station(
        station_name: "Sinillawain Station",
        latitude: 30.89243,
        longtitude: 31.47059,
      ),
      Station(
        station_name: "Mansoura Station",
        latitude: 31.05845,
        longtitude: 31.39506,
      ),
      Station(
        station_name: "Luxor Station",
        latitude: 25.69669,
        longtitude: 32.64469,
      ),
      Station(
        station_name: "Fayum Station",
        latitude: 29.30915,
        longtitude: 30.84776,
      ),
      Station(
        station_name: "Aswan Station",
        latitude: 24.1001,
        longtitude: 32.90222,
      ),
      Station(
        station_name: "Port Said Station",
        latitude: 31.26038,
        longtitude: 32.30106,
      ),
      Station(
        station_name: "Alexandria Station",
        latitude: 31.1937,
        longtitude: 29.90663,
      ),
      Station(
        station_name: "Marsa Matruh Train Station",
        latitude: 31.34901,
        longtitude: 27.24439,
      ),
    ],
    images: [
      'https://upload.wikimedia.org/wikipedia/commons/b/b1/Ramses-Station.jpg',
      'https://www.railwaypro.com/wp/wp-content/uploads/2021/04/Egypt-pass-train.jpg',
      'https://www.globaltimes.cn/Portals/0/attachment/2022/2022-06-30/39d64985-0a5e-4ddd-9aea-38a5c7a476d9.jpeg'
    ],
  ),
  Transport(
    id: "3",
    Title: "Metro",
    subtitle: "The Cairo Metro is Egypts main rapid transit system, serving millions daily across Cairo and Giza. Its fast, affordable, and the first of its kind in Africa and the Arab world.",
    price: "100",
    station: [
      Station(
        station_name: "Helwan",
        latitude: 29.84919,
        longtitude: 31.33434,
      ),
      Station(
        station_name: "Ain Helwan",
        latitude: 29.86281,
        longtitude: 31.32485,
      ),
      Station(
        station_name: "Helwan uni",
        latitude: 29.87049,
        longtitude: 31.32002,
      ),
      Station(
        station_name: "Wadi hof",
        latitude: 29.8792,
        longtitude: 31.31367,
      ),
      Station(
        station_name: "Hadyek Helwan",
        latitude: 29.89126,
        longtitude: 31.30398,
      ),
      Station(
        station_name: "El-Massara",
        latitude: 29.90631,
        longtitude: 31.29942,
      ),
      Station(
        station_name: "Tura El-Asmant",
        latitude: 29.9262,
        longtitude: 31.28752,
      ),
      Station(
        station_name: "Kozzika",
        latitude: 29.9364,
        longtitude: 31.28182,
      ),
      Station(
        station_name: "Tora El Balad",
        latitude: 29.947,
        longtitude: 31.27302,
      ),
      Station(
        station_name: "Sakant El Maadi",
        latitude: 29.95314,
        longtitude: 31.26346,
      ),
      Station(
        station_name: "Maadi",
        latitude: 29.9605,
        longtitude: 31.25762,
      ),
      Station(
        station_name: "Hadyek El Maa",
        latitude: 29.97034,
        longtitude: 31.25056,
      ),
      Station(
        station_name: "Dar El Salam",
        latitude: 29.98232,
        longtitude: 31.24229,
      ),
      Station(
        station_name: "El Zahraa",
        latitude: 29.99572,
        longtitude: 31.23118,
      ),
      Station(
        station_name: "Mar Girgis",
        latitude: 30.00626,
        longtitude: 31.22964,
      ),
      Station(
        station_name: "El Malek EL Sal",
        latitude: 30.01793,
        longtitude: 31.23109,
      ),
      Station(
        station_name: "Al Sayeda Zein",
        latitude: 30.02952,
        longtitude: 31.23545,
      ),
      Station(
        station_name: "Saad Zaghloul",
        latitude: 30.03735,
        longtitude: 31.23831,
      ),
      Station(
        station_name: "Sadat",
        latitude: 30.04441,
        longtitude: 31.23445,
      ),
      Station(
        station_name: "Nasser",
        latitude: 30.0536,
        longtitude: 31.23886,
      ),
      Station(
        station_name: "Orabi",
        latitude: 30.05685,
        longtitude: 31.24216,
      ),
      Station(
        station_name: "Al Shohadaa",
        latitude: 30.0612,
        longtitude: 31.24606,
      ),
      Station(
        station_name: "Ghamra",
        latitude: 30.06914,
        longtitude: 31.26463,
      ),
      Station(
        station_name: "El Demerdash",
        latitude: 30.07751,
        longtitude: 31.27777,
      ),
      Station(
        station_name: "Manshie El Sad",
        latitude: 30.08223,
        longtitude: 31.28751,
      ),
      Station(
        station_name: "Kobri El Qobba",
        latitude: 30.08739,
        longtitude: 31.29402,
      ),
      Station(
        station_name: "Hammamat El",
        latitude: 30.09142,
        longtitude: 31.29893,
      ),
      Station(
        station_name: "Saray El Qobba",
        latitude: 30.09792,
        longtitude: 31.30462,
      ),
      Station(
        station_name: "Hadayeq el Zei",
        latitude: 30.10752,
        longtitude: 31.30997,
      ),
      Station(
        station_name: "Helmiet El Zait",
        latitude: 30.11412,
        longtitude: 31.31411,
      ),
      Station(
        station_name: "El matariyyah",
        latitude: 30.12395,
        longtitude: 31.31286,
      ),
      Station(
        station_name: "Ain Shams",
        latitude: 30.13127,
        longtitude: 31.31901,
      ),
      Station(
        station_name: "Ezbet El Nakhl",
        latitude: 30.13951,
        longtitude: 31.32441,
      ),
      Station(
        station_name: "El Marg",
        latitude: 30.15393,
        longtitude: 31.33571,
      ),
      Station(
        station_name: "New El Marg",
        latitude: 30.16401,
        longtitude: 31.33834,
      ),
      Station(
        station_name: "شبرا الخيمه",
        latitude: 30.12433,
        longtitude: 31.24325,
      ),
      Station(
        station_name: "كليه الزراعه",
        latitude: 30.12246,
        longtitude: 31.24449,
      ),
      Station(
        station_name: "المظلات",
        latitude: 30.10444,
        longtitude: 31.24558,
      ),
      Station(
        station_name: "الخلفاوي",
        latitude: 30.0977,
        longtitude: 31.24549,
      ),
      Station(
        station_name: "سانت تريزا",
        latitude: 30.08805,
        longtitude: 31.24556,
      ),
      Station(
        station_name: "روض الفرج",
        latitude: 30.08078,
        longtitude: 31.24539,
      ),
      Station(
        station_name: "مسره",
        latitude: 30.07113,
        longtitude: 31.24505,
      ),
      Station(
        station_name: "الشهداء",
        latitude: 30.06179,
        longtitude: 31.24606,
      ),
      Station(
        station_name: "عتبه",
        latitude: 30.05258,
        longtitude: 31.24676,
      ),
      Station(
        station_name: "محمد نجيب",
        latitude: 30.04557,
        longtitude: 31.24421,
      ),
      Station(
        station_name: "السادات",
        latitude: 30.04376,
        longtitude: 31.23589,
      ),
      Station(
        station_name: "اوبرا",
        latitude: 30.04205,
        longtitude: 31.22485,
      ),
      Station(
        station_name: "الدقي",
        latitude: 30.03841,
        longtitude: 31.2114,
      ),
      Station(
        station_name: "البحوث",
        latitude: 30.03597,
        longtitude: 31.20016,
      ),
      Station(
        station_name: "جامعه القاهره",
        latitude: 30.02529,
        longtitude: 31.20174,
      ),
      Station(
        station_name: "فيصل",
        latitude: 30.01714,
        longtitude: 31.20401,
      ),
      Station(
        station_name: "الجيزه",
        latitude: 30.01127,
        longtitude: 31.20657,
      ),
      Station(
        station_name: "ضواحي الجيزه",
        latitude: 30.0059,
        longtitude: 31.20801,
      ),
      Station(
        station_name: "ساقيه مكي",
        latitude: 29.9958,
        longtitude: 31.20856,
      ),
      Station(
        station_name: "المنيب",
        latitude: 29.98134,
        longtitude: 31.21245,
      ),
      Station(
        station_name: "عدلي منصور",
        latitude: 30.14709,
        longtitude: 31.42121,
      ),
      Station(
        station_name: "الهايكستيب",
        latitude: 30.144,
        longtitude: 31.40469,
      ),
      Station(
        station_name: "عمر بن الخطاب",
        latitude: 30.14057,
        longtitude: 31.39429,
      ),
      Station(
        station_name: "قباء",
        latitude: 30.13503,
        longtitude: 31.38408,
      ),
      Station(
        station_name: "هشام بركات",
        latitude: 30.13111,
        longtitude: 31.37286,
      ),
      Station(
        station_name: "النزهه",
        latitude: 30.12812,
        longtitude: 31.36069,
      ),
      Station(
        station_name: "نادي الشمس",
        latitude: 30.12565,
        longtitude: 31.34878,
      ),
      Station(
        station_name: "الف مسكن",
        latitude: 30.11925,
        longtitude: 31.34018,
      ),
      Station(
        station_name: "هليوبوليس",
        latitude: 30.10856,
        longtitude: 31.33836,
      ),
      Station(
        station_name: "هارون",
        latitude: 30.10147,
        longtitude: 31.33286,
      ),
      Station(
        station_name: "الأهرام",
        latitude: 30.09185,
        longtitude: 31.32591,
      ),
      Station(
        station_name: "كليه البنات",
        latitude: 30.08359,
        longtitude: 31.32897,
      ),
      Station(
        station_name: "ستاد القاهرة",
        latitude: 30.07412,
        longtitude: 31.31771,
      ),
      Station(
        station_name: "ارض المعارض",
        latitude: 30.07339,
        longtitude: 31.3009,
      ),
      Station(
        station_name: "العباسيه",
        latitude: 30.07223,
        longtitude: 31.28337,
      ),
      Station(
        station_name: "عبده باشا",
        latitude: 30.06499,
        longtitude: 31.2747,
      ),
      Station(
        station_name: "الجيش",
        latitude: 30.06202,
        longtitude: 31.26704,
      ),
      Station(
        station_name: "باب الشعريه",
        latitude: 30.0544,
        longtitude: 31.25593,
      ),
      Station(
        station_name: "ماسبيرو",
        latitude: 30.05597,
        longtitude: 31.23213,
      ),
      Station(
        station_name: "صفاء حجازي",
        latitude: 30.06251,
        longtitude: 31.2226,
      ),
      Station(
        station_name: "الكيت كات",
        latitude: 30.06658,
        longtitude: 31.21266,
      ),
      Station(
        station_name: "السودان",
        latitude: 30.07018,
        longtitude: 31.20445,
      ),
      Station(
        station_name: "امبابه",
        latitude: 30.07639,
        longtitude: 31.20701,
      ),
      Station(
        station_name: "البوهي",
        latitude: 30.08296,
        longtitude: 31.20997,
      ),
      Station(
        station_name: "القوميه العربيه",
        latitude: 30.09323,
        longtitude: 31.20914,
      ),
      Station(
        station_name: "الطريق الدائري",
        latitude: 30.09663,
        longtitude: 31.19941,
      ),
      Station(
        station_name: "محور روض الفرج",
        latitude: 30.10204,
        longtitude: 31.18434,
      ),
      Station(
        station_name: "التوفيقيه",
        latitude: 30.06497,
        longtitude: 31.20245,
      ),
      Station(
        station_name: "وادي النيل",
        latitude: 30.05866,
        longtitude: 31.20102,
      ),
      Station(
        station_name: "جامعه الدول العربيه",
        latitude: 30.05036,
        longtitude: 31.1989,
      ),
      Station(
        station_name: "بولاق الدكرور",
        latitude: 30.03782,
        longtitude: 31.19555,
      ),
    ],
    images: [
      'https://www.arabcont.com/Images/ProjectImage/Metro-3A-15.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/9/95/Metro-1-l.jpg',
      'https://bect-bak.s3.amazonaws.com/media/images/https%3A/bect.s3.amazonaws.com/media/BECT_Consulting_cairo_metro_train_hyundai_Engineering.jpg'
    ],
  ),
  Transport(
    id: "4",
    Title: "Go Bus",
    subtitle: "Go Bus is an Egyptian shareholding company working in the field of public transport under the supervision of the Ministry of Transport since 1998. It is the first private sector company operating in the area of public transportation.",
    price: "100",
    station: [
      Station(
        station_name: "رمسيس",
        latitude: 30.06206,
        longtitude: 31.24533,
      ),
      Station(
        station_name: "القللي",
        latitude: 30.06079,
        longtitude: 31.24321,
      ),
      Station(
        station_name: "6 أكتوبر",
        latitude: 29.98629,
        longtitude: 30.95214,
      ),
      Station(
        station_name: "مدينتي",
        latitude: 30.10287,
        longtitude: 31.61122,
      ),
      Station(
        station_name: "الرحاب",
        latitude: 30.05308,
        longtitude: 31.48889,
      ),
      Station(
        station_name: "بوابة القاهرة اسكندرية الصحراوي",
        latitude: 30.07026,
        longtitude: 31.01439,
      ),
      Station(
        station_name: "صقر قريش",
        latitude: 29.98709,
        longtitude: 31.28798,
      ),
      Station(
        station_name: "الجيزه",
        latitude: 30.01806,
        longtitude: 31.21469,
      ),
      Station(
        station_name: "ألماظه",
        latitude: 30.08495,
        longtitude: 31.35259,
      ),
      Station(
        station_name: "مدينة نصر (نادي السكة)",
        latitude: 30.05831,
        longtitude: 31.30283,
      ),
      Station(
        station_name: "عبد المنعم رياض",
        latitude: 30.05064,
        longtitude: 31.23316,
      ),
      Station(
        station_name: "مدينه نصر (الحي السادس)",
        latitude: 30.04703,
        longtitude: 31.31916,
      ),
      Station(
        station_name: "التجمع الخامس",
        latitude: 30.01696,
        longtitude: 31.43222,
      ),
      Station(
        station_name: "سفاجا",
        latitude: 26.75203,
        longtitude: 33.94054,
      ),
      Station(
        station_name: "مرسى علم",
        latitude: 25.06803,
        longtitude: 34.88738,
      ),
      Station(
        station_name: "القيصر",
        latitude: 26.11833,
        longtitude: 34.27422,
      ),
      Station(
        station_name: "الجونه",
        latitude: 27.39619,
        longtitude: 33.67421,
      ),
      Station(
        station_name: "سوماباي",
        latitude: 26.85045,
        longtitude: 33.98538,
      ),
      Station(
        station_name: "مكادي",
        latitude: 26.96249,
        longtitude: 33.87805,
      ),
      Station(
        station_name: "سهل حشيش",
        latitude: 27.0786,
        longtitude: 33.88244,
      ),
      Station(
        station_name: "السقاله",
        latitude: 27.23971,
        longtitude: 33.83126,
      ),
      Station(
        station_name: "الغردقة الرأيسي",
        latitude: 27.2383,
        longtitude: 33.83188,
      ),
      Station(
        station_name: "رأس سدر",
        latitude: 29.56682,
        longtitude: 32.75005,
      ),
      Station(
        station_name: "ميدان الثلاث سمكات",
        latitude: 29.59097,
        longtitude: 32.72164,
      ),
      Station(
        station_name: "قرية تافيرا",
        latitude: 29.31394,
        longtitude: 32.84192,
      ),
      Station(
        station_name: "مطارما بك",
        latitude: 29.43472,
        longtitude: 32.78138,
      ),
      Station(
        station_name: "لاهاسيندا",
        latitude: 29.3826,
        longtitude: 32.82501,
      ),
      Station(
        station_name: "دهب",
        latitude: 28.49566,
        longtitude: 34.51518,
      ),
      Station(
        station_name: "الرويسات",
        latitude: 27.90024,
        longtitude: 34.28778,
      ),
      Station(
        station_name: "شرم",
        latitude: 27.88369,
        longtitude: 34.30077,
      ),
      Station(
        station_name: "شرم (الوطنيه)",
        latitude: 27.88381,
        longtitude: 34.30076,
      ),
      Station(
        station_name: "العامريه",
        latitude: 31.00751,
        longtitude: 29.80162,
      ),
      Station(
        station_name: "ابيس",
        latitude: 31.20635,
        longtitude: 29.99262,
      ),
      Station(
        station_name: "ميامي",
        latitude: 31.26841,
        longtitude: 29.99995,
      ),
      Station(
        station_name: "سيدي جابر",
        latitude: 31.21911,
        longtitude: 29.94431,
      ),
      Station(
        station_name: "محرم بك",
        latitude: 31.17774,
        longtitude: 29.91427,
      ),
      Station(
        station_name: "مارينا 5",
        latitude: 30.83263,
        longtitude: 28.96368,
      ),
      Station(
        station_name: "مارينا 7",
        latitude: 30.84156,
        longtitude: 28.94808,
      ),
      Station(
        station_name: "ستيلا سيدى عبد الرحمن",
        latitude: 30.95265,
        longtitude: 28.76986,
      ),
      Station(
        station_name: "مراسي",
        latitude: 31.0108,
        longtitude: 28.784,
      ),
      Station(
        station_name: "مرسى مطروح",
        latitude: 31.33713,
        longtitude: 27.25297,
      ),
      Station(
        station_name: "جراند اوشن",
        latitude: 29.3614,
        longtitude: 32.5734,
      ),
      Station(
        station_name: "بورتو ساوث بيتش",
        latitude: 29.34753,
        longtitude: 32.57933,
      ),
      Station(
        station_name: "كانكون",
        latitude: 29.28446,
        longtitude: 32.60147,
      ),
      Station(
        station_name: "بورتو السخنه",
        latitude: 29.44431,
        longtitude: 32.48579,
      ),
      Station(
        station_name: "قنا سيدي عبد الرحيم",
        latitude: 26.16443,
        longtitude: 32.7263,
      ),
      Station(
        station_name: "قنا الكوبري",
        latitude: 26.16403,
        longtitude: 32.7264,
      ),
      Station(
        station_name: "قنا ميدان المحطه",
        latitude: 26.1629,
        longtitude: 32.72585,
      ),
      Station(
        station_name: "المحله",
        latitude: 30.0467,
        longtitude: 31.3185,
      ),
      Station(
        station_name: "طنطا",
        latitude: 30.79287,
        longtitude: 30.98386,
      ),
      Station(
        station_name: "بور سعيد داون تاون",
        latitude: 31.24769,
        longtitude: 32.2671,
      ),
      Station(
        station_name: "بور سعيد موقف مصر",
        latitude: 31.23948,
        longtitude: 32.29012,
      ),
      Station(
        station_name: "موقف المعلمين الجديد",
        latitude: 27.17018,
        longtitude: 31.19829,
      ),
      Station(
        station_name: "الهلالي",
        latitude: 27.18101,
        longtitude: 31.19009,
      ),
      Station(
        station_name: "ملوي",
        latitude: 27.73792,
        longtitude: 30.84427,
      ),
      Station(
        station_name: "المنيا",
        latitude: 28.09536,
        longtitude: 30.75322,
      ),
      Station(
        station_name: "الأقصر",
        latitude: 25.69802,
        longtitude: 32.64481,
      ),
      Station(
        station_name: "المنصوره",
        latitude: 31.04532,
        longtitude: 31.39538,
      ),
      Station(
        station_name: "الأسماعلية",
        latitude: 30.58679,
        longtitude: 32.26747,
      ),
    ],
    images: ['https://img.12go.asia/0/plain/s3://12go-web-static/static/images/operator/18597/class/3713-outside.jpeg', 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/28/5c/7c/5b/aero-first-class.jpg?w=1200&h=-1&s=1', 'https://go-bus.com/images/new-bus-classes/go-mini/1.jpg'],
  ),
];
