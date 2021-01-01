import 'package:Mafia/models/role.dart';

class Roles {
  find(String name) {
    return mafia.firstWhere(
      (element) => element.name == name,
      orElse: () => citizen.firstWhere(
        (element) => element.name == name,
        orElse: () => independent.firstWhere(
          (element) => element.name == name,
        ),
      ),
    );
  }

  List<Role> mafia = [
    Role(
      name: 'رئیس مافیا',
      type: 'M',
      order: 1,
      job: """سردسته تیم و مهم ترین شخصیت مافیا است که هر شب میتونه یکی رو بکشه
        رییس، مافیایی هستش که مستقیما مقتول شب رو انتخاب میکنه و دستور قتل رو خودش میده
        و در صورت حذفش از بازی اگر معشوقه توی بازی نباشه مافیا های دیگه باید با مشورت هم مقتول شب رو انتخاب کنند و بهش شلیک کنند 
        اگر معشوقه توی بازی باشه داستان فرق میکنه و حکم تیر رییس به اون منتقل میشه
        اگر کارآگاه استعلام رییس مافیارو بگیره گرداننده به اون جواب منفی میده
        مرگ رییس مافیا باعث دو دستگی و تفرقه بین مافیا میشه و اونارو ضعیف میکنه """,
    ),
    Role(
      name: "معشوقه",
      type: 'M',
      order: 2,
      job: """با مرگ او مافیا از شدت خشم به دو نفر حمله میکند
      با مرگ رییس مافیا او جای رییس را میگیرد""",
    ),
    Role(
      name: "بمب ساز",
      type: 'M',
      order: 3,
      job: """بمب ساز نقش مقابل فدایی هستش که میشه گفت کارایی یکسانی دارند 
      بمب ساز هم مثل فدایی قبل از اتمام رای گیری هر روز اگر احساس خطر کرد میتونه بلند شه و منفجر شه
      با اعلام نقشش به بازی کنان دیگ میفهمونه ک قراره یه شهروند رو از جمعشون خارج کنه و با خودش ببره 
      ولی تفاوتش با فدایی اینه که در زمان منفجر شدنش گرداننده بازی یک فرصت هفت ثانیه ای به شهوندا میده 
      ک اگر فدایی توی بازی حضور داشت خودش رو فدای هم تیمی هاش کنه و نزاره شهروند مفیدی از بازی خارج شه""",
    ),
    Role(
      name: "روانکاو/وکیل",
      type: 'M',
      order: 4,
      job:
          """قابلیت روانکاو اینه که میتونه در طول بازی به جز شب اول یک نفر رو انتخاب کنه 
      شخصیت انتخاب شده توسط روانکاو نمیتونه جانی و یا مستقل باشه
      و اون شخص با حفظ تمام قابلیت هاش به مافیا تبدیل میشه""",
    ),
    Role(
      name: "جراح",
      type: 'M',
      order: 5,
      job:
          """عملکرد اون شبیه به دکتر میباشد و در شب یکی از مافیا رو سیو میکنه در شب اول همراه
       با دکتر برای شهردار بیدار میشه تا شهردار نتونه جراح و دکتر رو تشخیص بده""",
    ),
    Role(
      name: "جلب",
      type: 'M',
      order: 6,
      job:
          """ شب ها در طول بازی میتواند یک نفر را انتخاب کنید و رای اون بازیکن روز بعد حساب نمیشود 
      همچنان میتواند  در روز به یک نفر دو رای بدهد""",
    ),
    Role(
      name: "شب خسب",
      type: 'M',
      order: 7,
      job:
          """در شب یکی را انتخاب میکند و اون شخصیت هر کاری کنه به خودش برمیگرده در صورت انتخاب جادوگر میمیره""",
    ),
    Role(
      name: "محافظ",
      type: 'M',
      order: 8,
      job: """در صورت وجودش تو بازی حمله در شب به رئیس مافیا بی تاثیر میشه""",
    ),
    Role(
      name: "شارلاتان/تهمت زن",
      type: 'M',
      order: 9,
      job:
          """یک شخص رو انتخاب میکنه و اگر کاآگاه استعلام اون شخص بگیره گرداننده برعکسش رو به اون میگه""",
    ),
    Role(
      name: "قاتل حرفه ای",
      type: 'M',
      order: 10,
      job:
          """فقط یک بار در بازی در شب یک نفر را انتخاب کرده و اون فرد سه روز بعد وسط روز حذف میشه""",
    ),
    Role(
      name: "آمپول زن",
      type: 'M',
      order: 11,
      job:
          """یکبار در بازی در شب استعاتم یک نفر را از گرداننده میگیره و گرداننده بازی نقش اون شخصو اعلام میکنه و اعلام میکنه چیکار کرده""",
    ),
    Role(
      name: "دو رو",
      type: 'M',
      order: 12,
      job:
          """مافیایی ک با مافیا بیدار نمیشع ولی مافیا رو میشناسه و استعلامش هم مثبته""",
    ),
    Role(
      name: "کارآگاه ویژه",
      type: 'M',
      order: 12,
      job:
          """هر شب بخواهد میتواند یک نفر را انتخاب کند گرداننده به او میگوید ک شخصیت مستقل است یا نه.
          دو بار استعلام منفی بگیرد از بازی حذف میشود""",
    ),
    Role(
      name: "شاه کش",
      type: 'M',
      order: 12,
      job: """متخصص در کشتن
بازیکن ها باید ازین به بعد حواسشون باشه که در جریان بازی هیچ اشاره ای به نقششون نداشته باشن. چون از حالا مافیا یه نفر رو داره که میتونه بلافاصله اقدام به کشتن اون شخص کنه. بله؛ شاه کش تو کمینه!
اون حواسش به همه ی حرف ها هست تا بفهمه هر کسی چه اطلاعاتی از نقشش داره میده.
دو بار در طول بازی میتونه بازیکنی رو انتخاب کنه و نقشش رو مخفیانه به گرداننده بگه اگه درست حدس زده باشه اون شخص از بازی حذف میشه!
هم در شب میتونه کارشو انجام بده هم توی روز توی مرحله ی دوم رای گیری.
کسی رو که شاه کش بکشه حتی دکتر و جراح هم نمیتونن نجات بدن!
اگه هزارچهره رو انتخاب کنه خودش از بازی حذف میشه!
و البته نمیتونه بازیکنی که قهرمان انتخابش کرده رو بکشه!""",
    ),
    Role(
        name: 'ناتاشا',
        type: 'M',
        order: 13,
        job:
            "ناتاشا در شب به یکی از بازیکن ها سکوت میدهد آن بازیکن در روز بعد نمیتواند حرف بزند یا حرف دیگران را تایید یا رد کند و حتی در رای گیری نیز شرکت نمیکند ، ناتاشا نمیتواند یک نفر را در دو شب متوالی سکوت دهد"),
  ];
  //==================================================================    CITIZEN    =============================================================//
  List<Role> citizen = [
    Role(
      name: 'شهردار',
      type: 'C',
      order: 20,
      job:
          """شهردار به طور کل یکی از مهم ترین شخصیت های شهروندی بازی است یا به قولی رئیس شهروند هاست.
         دکتر رو میشناسه و میتونه با صحبتا و سیاست هایی که به خرج میده دکتر رو تو بازی نگه داره.
         وقتی حس کرد که توی رای گیری روزدو شهروند در حال حذف شدن هستند میتونه رای گیری رو ملغی کنه 
         و در نهایت اگر شهردار بازی کشته بشه شهروندان شخصیت مهمی را از دست خواهند داد.
         """,
    ),
    Role(
      name: "قاضی",
      type: 'C',
      order: -11,
      job:
          """دوبار در طول بازی اگر لازم بداند در مرحله دوم رای گیری یک شخص را انتخاب کرده و آن شخص از بازی خارج میشود""",
    ),
    Role(
      name: "فدایی",
      type: 'C',
      order: 22,
      job:
          """همونظور که از اسم این شخصیت پیداست شجاع ترین شخصیت تیم شهروند هستش ک در زمان های حساس و اضطراری 
      با شجاعت هویت خودش رو فاش میکنه و به قولی خودش رو فدای هم تیمی هاش میکنه 
      فدایی اگه بتونه تشخیص بده کدوم یک از افراد داخل بازی مافیا یا مستقل هستش میتونه قبل از اتمام رای گیری 
      بلند شه و اون شخصیت رو با خودش از بازی خارج کنه""",
    ),
    Role(
      name: "دکتر",
      type: 'C',
      order: 23,
      job:
          """شخصیتی که فقط شهردار بازی او را میشناسد و کارایی مهمی هم داره کارشم اینه ک شهروند های مهمی ک خودش شناسایی میکنه
      رو در طول شب سیو میکنه یا نجات میده از تیر مافیا و نمیزاره ک شهروندای مهم به سادگی از گردونه بازی حذف بشن
      در طول بازی فقط یک شب میتواند خودش را سیو کند""",
    ),
    Role(
      name: "گورکن",
      type: 'C',
      order: 24,
      job:
          """قابلیت گورکن به بیان ساده اینه که اگر بازیکنی از بازی بیرون بره برای رو شدن کارتش برای بقیه بازیکن ها 
      و برای اینکه بفهمن چخبره و کی رفته کی مونده و غیره کافیه گورکن تو بازی باشه و از قابلیتش استفاده کنه""",
    ),
    Role(
      name: "کارآگاه",
      type: 'C',
      order: 25,
      job:
          """کارآگاه میتونه هر شب استعلام یکی از بازیکن های حاظر در بازی رو از راوی بگیره
      و گرداننده منفی یا مثبت بودن نقش اون بازیکن رو به کارآگاه اعلام میکنه 
      (استعلام گادفادر همیشه مثبت خواهد بود یعنی گاد اون رو شهروند اعلام میکنه)""",
    ),
    Role(
      name: "کلانتر/تک تیر انداز",
      type: 'C',
      order: 26,
      job:
          """کلانتر شهروندیه  که تو فاز شب میتونه یکی از بازیکنان حاظر در بازی رو انتخاب کنه و بهش شلیک کنه ولی باید مراقب باشه
      چرا که اگر مافیا رو بزنه مافیا حذف میشه ولی اگر شهروند رو بزنه خودش حذف میشه""",
    ),
    Role(
      name: "قهرمان",
      type: 'C',
      order: 27,
      job:
          """قابلیت قهرمان اینه که هر دو شب توسط گرداننده بیدار میشه و یک نفر رو نجات میده
      سیو قهرمان خیلی قویه و اون شخصی که سیو شده از تمام حملات بیست و چهار ساعت اینده در امان میمونه و حذف نمیشع""",
    ),
    Role(
      name: "ناقل",
      type: 'C',
      order: 28,
      job:
          """کسی ک ناقل رو انتخاب کنه بیمار میشه روز بعدش لال میشه شب بعدش هیچ کاری نمیتونه انجام بده و در شب دوم میمیره""",
    ),
    Role(
      name: "رویین تن",
      type: 'C',
      order: 29,
      job: """یکبار در شب توسط تیر مافیا کشته نمیشه""",
    ),
    Role(
      name: "دست کج",
      type: 'C',
      order: 30,
      job:
          """یکبار در بازی یک شخصیت رو انتخاب میکنه و اون شخصیت تمام قابلیت هاشو از دست میده 
      ولی قابلیتش روی کارآگاه و نقش های مستقل بی تاثیره""",
    ),
    Role(
      name: "نانوا",
      type: 'C',
      order: 31,
      job: """اگر نانوا کشته شه پنج شب بعد همه شهروندان به علت گرسنگی میمیرن""",
    ),
    Role(
      name: "دندانپزشک",
      type: 'C',
      order: 32,
      job:
          """فقط یک بار در بازی یک نفر رو انتخاب میکنه و اون شخص تا آخر بازی  نمیتواند صحبت کند""",
    ),
    Role(
      name: "فرشته",
      type: 'C',
      order: 33,
      job:
          """هر بازیکن وقتی در رای گیری حذف میشود اگر فرشته نجات را درست حدث بزند نجات پیدا میکند""",
    ),
    Role(
      name: "وکیل",
      type: 'C',
      order: 34,
      job: """در رای گیری وکالت یک نفر را میکند و او از بازی حذف نمیشود""",
    ),
    Role(
      name: "زندانبان",
      type: 'C',
      order: 35,
      job:
          """دو بار در بازی یک نفر رو به مدت 24 ساعت به زندان میفرسته و اون بازیکن به مدت 24 ساعت (یک روز و یک شب) از بازی حذف میشه""",
    ),
    Role(
      name: "کشیش",
      type: 'C',
      order: 36,
      job: """در اولین سو قصد به جونش زنده میمونه چون خدا پشتشه
      هر سه شب یکبار یکیو انتخاب میکنه اگر گرگ نما باشه به شهروند تبدیل میشه""",
    ),
    Role(
      name: "سیمین",
      type: 'C',
      order: 37,
      job: """در شب استعلام گرگ نما هارو از گرداننده بازی میگیره""",
    ),
    Role(
      name: "جادوگر",
      type: 'C',
      order: 38,
      job:
          """یکبار در بازی در شب یا رای گیری یک نفر رو انتخاب میکنه و 24 ساعت تمام قابلیت های اون شخص ازش گرفته میشه""",
    ),
    Role(
      name: "شکارچی",
      type: 'C',
      order: 39,
      job: """هر دو شب یکبار یکی رو انتخاب میکنه اگر گرگ نما باشه کشته میشه""",
    ),
    Role(
      name: "جاسوس",
      type: 'C',
      order: 40,
      job: """شهروندی ک با مافیا بیدار میشه و باید دو پهلو بازی کنه""",
    ),
    Role(
      name: "ساقی",
      type: 'C',
      order: -10,
      job:
          """یک تفر را در شب انتخاب کرده مست میکند و فرد مست نمیتواند به درستی وضیفه خود را انجام دهد""",
    ),
    Role(
      name: "تفنگ دار",
      type: 'C',
      order: 41,
      job:
          """در فاز شب بسته به تعداد بازیکنان یک یا چند شب میتواند به یکی از بازیکنان تفنگ بدهد 
      و آن شخص نیز در روز و قبل از دفاعیه میتواند یک نفر را به قتل برساند، 
      در صورتی که گیرنده تفنگ سایلنت شده باشد نمی تواند از آن استفاده کند""",
    ),
    Role(
      name: "فراماسون",
      type: 'C',
      order: 42,
      job: """هر شب بیدار شده و یک نفر را انتخاب میکند.
          اگر آن شخص شهروند بوده باشد همدیگر را میشناسند و تعداد شهروند های مطلع هر شب بیشتر میشود 
          اما اگر فردی ک بیدار میکند مافیا باشد تمامی فراماسون ها از بازی حذف میشوند مگر این که جاسوس را بیدار کند
          در اینصورت جاسوس به آنها نفوذ کرده و اطلاعات غلط به آنها میدهد""",
    ),
    Role(
      name: "صبا",
      type: 'C',
      order: 43,
      job: """شبیه ساز!
اگه انتخاب های درستی داشته باشه میتونه شهروند خیلی قوی باشه و اگه اگه توی انتخاب هاش اشتباه داشته باشه میتونه ضرر های سنگینی به شهروندها بزنه.
صبا توانایی تصاحب هویت و قابلیت نقش های دیگران رو داره!
اون ۲ شب در طول بازی میتونه بازیکنی رو انتخاب کنه و نقش اون بازیکن رو به مدت ۲۴ ساعت تصاحب کنه. صبا \"باید\" از قابلیت نقشی که گرفته استفاده کنه و استثنایی وجود نداره اینجاست توی انتخابش باید دقت کنه چون ممکنه به خودش یا شهروندا آسیب بزنه چراکه ممکنه با بعضی انتخاب هاش به عضویت گروه های غیر شهروندی دربیاد و
اجرای بعضی از قابلیت ها منجر به حذف خودش بشه
مسلما وقتی میتونه نقش دو نفر رو تصاحب کنه در ادامه ی بازی از نقش دو تا از بازیکن ها آگاهی داره که امتیاز بزرگیه.

نمیتونه هزار چهره رو تصاحب کنه و با انتخابش خودِ صبا میمیره.
اگه توی شبی که میخواد نقش کسی رو تصاحب کنه شب خسب بهش زده باشه صبا میمیره.""",
    ),
  ];
  //==================================================================    INDEPENDENT    =============================================================//
  List<Role> independent = [
    Role(
      name: "هزار چهره",
      type: 'I',
      order: 50,
      job:
          """شخصیت هر بازیکنی که با رای گیری از بازی خارج می شود را به مدت 24 ساعت تصاحب میکند
       هر شخصی ک کاری رو او انجام دهد اثر آن کار به خودش بر می گردد آینه وار
       شرط پیروزی او باقی ماندن بین سه نفر آخر است """,
    ),
    Role(
      name: "جانی",
      type: 'I',
      order: 51,
      job:
          """قابلیت جانی اینه ک هر دو شب یک بار بیدار میشه و به یک نفر تیر میزنه و در این شب ها مافیا نمیتونه اونو مورد حمله قرار بده 
      جانی برای بردن بازی باید تمام شخصیت های مستقل و مافیا رو حذف کنهو بین دو نفر آخر بازی باشه""",
    ),
    Role(
      name: "مجهول",
      type: 'I',
      order: 52,
      job: """اولین بار توسط هر تیمی زده شه نمیمیره و به اون تیم ملحق میشه""",
    ),
    Role(
      name: "گرگ نما",
      type: 'I',
      order: 53,
      job:
          """هر سه شب یکبار بیدار شده و یک نفر رو گاز میگیره و به گرگ تبدیل میکنه 
      فقط شکارچی . کشیش رو نمیتونه تبدیل کنه""",
    ),
    Role(
      name: "عماد",
      type: 'I',
      order: 54,
      job: """در شب معارفه دو نفر رو به عنوان پیش مرگ انتخاب میکنه
      اگر تیر بخوره اول پیشمرگاش میمیرن
      اگر در رای گیری یا توسط فدایی حذف بشه پیشمرگ هاش بهمراه خودش حذف میشن""",
    ),
    Role(
      name: "سندیکا",
      type: 'I',
      order: 55,
      job:
          """با ایجاد یک لیست سیاه میتونه در مرحله دوم رای گیری یکی از لیست رو بکشه""",
    ),
    Role(
      name: "دورگه",
      type: 'I',
      order: 56,
      job:
          """هر شب یکی رو انتخاب میکنه و استعلام اون رو برای سیمین برعکس میکنه""",
    ),
    Role(
      name: "همزاد",
      type: 'I',
      order: 57,
      job:
          """یک نفر رو انتخاب میکنه و اگر اون شخص کشته شد همزاد جاش رو میگیره""",
    ),
    Role(
      name: "شیطان صفت",
      type: 'I',
      order: 57,
      job: """قاتل حریص که با گذشت زمان میل به کشتنش بیشتر و بیشتر میشه!
از شب دوم به بعد هرشب بیدار میشه و به تعداد عددِ اون شب بازیکن انتخاب میکنه مثلا اگه شب سوم باشه ۳ نفر رو انتخاب میکنه. اگه همه‌ی اون بازیکنها یک رنگ باشن همشون حذف میشن!!!
یا همه آبی یا همه قرمز یا همه مستقل.

و اگه یک رنگ نبودن اتفاقی نمیوفته و شیطان صفت باید منتظر شب بعدی باشه
چه درست انتخاب کنه چه غلط، هرشب باید کارشو انجام بده.
شیطان صفت زیردست هزار‌چهره و نایب هست. یعنی اگه هزار چهره حذف شه هم نایب و هم شیطان صفت حذف میشن. اگه نایب حذف شه شیطان صفت هم حذف میشه. شرط پیروزی شیطان صفت زنده موندن هزار‌چهره ست یعنی باید هزار‌چهره توی سه نفر آخر باشه. شیطان صفت به تنهایی شرایط برد نداره.

خوبه اینا رو هم بدونین:
با انتخاب ناقل آلوده نمیشه، جانی براش هم شهروند حساب میشه هم مستقل، تبدیل به گرگ نما نمیشه، روانکاوی نمیشه(خود روانکاو حذف میشه)، در مقابلِ صبا، نخبه، شاه کُش، افیون و افشاگر مصونیتی نداره.""",
    ),
    Role(
      name: "مریض",
      type: 'I',
      order: 57,
      job: """ آلوده به کروناست.
اولین بار که توسط بازیکنی انتخاب شود بدون اینکه اتفاقی برایش بیافتد، نقش او را کامل تصاحب می‌کند و آن بازیکن به یک شخصیت ساده تبدیل می‌شود و همچنین آلوده به کرونا می‌شود و جالب تر اینکه خودش از این موضوع کاملا بی خبر است. همچنین بازیکن هیچ علائمی از خود نشان نمی‌دهد و ٣ روز بعد به صورت ناگهانی از بازی حذف می‌شود.

-لحظه ای که شخصیت جدید را تصاحب می‌کند دیگر توانایی انتقال بیماری ندارد.
-اگر برای بار اول مورد حمله مافیا قرار بگیرد اولویت آلودگی به ترتیب زیر است:
رئیس مافیا، معشوقه و جانشین
-فرقی نمی کند اولین انتخاب شب باشد یا روز.
-شاهکش نمی‌تواند شخصیت او را حدس بزند.
-اگر همزاد انتخابش کند ،همزاد و مریض هر دو می‌میرند.
-در مقابل شخصیت های مستقل و جانی فقط بیماری را انتقال می‌دهد.""",
    ),
  ];
}
