import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sportsInjuries/screens/auth/auth.dart';
import 'package:sportsInjuries/screens/auth/waiting.dart';
import 'package:sportsInjuries/screens/home_screen.dart';
import 'package:sportsInjuries/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  // void postData() async {
  //   final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
  //       'BruisesInfo.json');
  //
  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({
  //       'bruise': {
  //         "def": [
  //           "الكدم هو عبارة عن هرس أنسجة عضو عن طريق قوة خارجية عنيفة مباشرة كالضرب مباشرة أو الاصطدام بجسم صلب وغالبًا ما يصاحب الكدم ألم وورم ونزيف داخلي وارتشاح لسائل بلازما الدم مكان الإصابة وتغيير في لون الجلد إلى الزرقة الداكنة أو الزرقة المشوبة باحمرار."
  //         ],
  //         "reasons": [
  //           "صدمه مباشره لسطح الجسم بجسم غير حاد او نتيجة العنف الخارجي من اللاعب او المنافس او السقوط على الارض ولا يتسبب عنها جرح في الجلد ،وقد ينتج عنها تجمع دموي، وتتوقف مقدره اللاعب على الاداء جزئيا او كليا حسب شده او درجه الإصابة.",
  //         ],
  //         "Symptoms": [
  //           ' ظهور ورم وانتفاخ نتيجة تجمع وتجلط الدم الجاري في هذه المنطقة .',
  //           'ألم في منطقة الكدمة.',
  //           'نزيف داخلي نتيجة تمزق الشعيرات الدموية قطع في استمرارية الجهاز الدوري',
  //           'عدم القدرة على الحركة مؤقتا بالنسبة للكدمات البسيطة ، وفقد القدرة على الحركة كليا بالنسبة للكدمات الشديدة بسبب الضغط الواقع على الأعصاب الحسية والحركية.',
  //           'تغير لون الأغشية والجلد الخارجي حيث تبدا الكدمة في البداية باللون الاحمر وتتغير للأزرق القاتم، ثم تتحول للبنفسجي، ثم الاخضر ثم تتحول الى الاصفر الشاحب حتى تمام الشفاء واختفاء اللون.وغالبا يتم الشفاء الكامل خلال اسبوع واسبوعين حسب شده الكدمة.'
  //         ],
  //         "firstAid": [
  //           'الراحة في وضع ملائم',
  //           'استخدام كمادات الثلج لمده( ١٠: ١٥ق )ايقاف النزيف داخلي ويقرر كل ساعتين خلال مرحله العلاج الاولي علي حسب درجه الإصابة.',
  //           'رفع العضو المصاب لأعلي بدون ألم .',
  //           ' ضغط على المفصل المصاب برباط ضاغط لتقليل نسبه الورم .'
  //         ]
  //       },
  //       'muscle contraction': {
  //         "def": [
  //           "هو حوج أو التقال أي مى العطام المكونه للمعصل عن مكانها الطبيعي وبفاءها حارج المقصل ودلك نتيجه إصابةصاشرة أو عير ماشعالما مايحدن تهتك وتلف في السحعظة الليعية والأنسحة المحيطة بالععصل ويحدت انسكاب للسائل الزلائي ونزيه",
  //         ],
  //         "reasons": [
  //           "الإجهاد العضلي لفتره طويله مما يؤدي لفقدان السوائل وترسب حمض اللاكتيك",
  //           "فقدان كميات كبيره من الأملاح و العرق الكثير",
  //           "عدم إحماء العضلات بدرجه كافيه",
  //           "تعرض العضلات للبروده المفاجئه",
  //           "اضطراب النظام العصبي او عدم تكامل الدوره الدمويه للعضلات"
  //               "تعرض العضلات لفترات طويله من الراحه والإسترخاء-نقص الأكسجين",
  //           "تشوهات قوس القدم",
  //         ],
  //         "Symptoms": [
  //           "ألم شديد في العضله",
  //           "تصلب في العضله خارج تحكم الفرد",
  //           "قصر في العضله"
  //         ],
  //         "firstAid": [
  //           "شد العضله المتقلصه في الإتجاه المعاكس",
  //           "تحويل الإنتباه العصبي لآلام التقلص العضلي",
  //           "تدفئة العضله",
  //           "تدليك بسيط"
  //         ]
  //       },
  //       'fracture': {
  //         "def": [
  //           "هو انفصال العظمة عن بعضها البعض إلى جزئين أو أكثر نتيجة للإصابات أو السقوط من سطح مرتفع أو لقوة خارجية شديدة وعنف خارجي اوالاصطدام بجسم صلب مثل ارتطام لاعب كرة قدم بقائم المرمى أو بالأرض أو بقدم الخصم",
  //         ],
  //         "shapes": [
  //           "كسر الغصن الأخضر / ( كسر غير النام ) وقد يحدث كسر غير كامل للعظام التي يكتمل تكلسها تماما.",
  //           "كسر مفتت ويحدث أثر صدمة أو سقوط في وضع غير مناسب مما يؤدي إلى وجود ثلاث أو أكثر من جزيئات العظمة في مكان الكسر.",
  //           "کسر مستعرض / يحدث هذا الكبير على شكل خط مستقيم بمنتصف ساق العظمة تقريباً..",
  //           "كسر حلزوني / وفيه يكون الفصال العظمة على شكل حلزوني أو حرف (s).",
  //           "كسر مشرشر / وفيه تكون جزئي العظمة ذات أسنان مشرشرة وحادة كالمنشار وذلك نتيجة لضربة مباشرة .",
  //           "كسر مضغوط / تحدث عالياً للعظام المسطحة مثل عظام الجمجمة . ( الرأس ) السقوط أو احتكاك جامد غير متحرك."
  //         ],
  //         "reasons": [
  //           "قوه خارجيه تؤدي الى صدمه شديده تصيب العظمة مسببه الكسر.",
  //           "الاصطدام بوزن ثقيل إسقاط شيء ثقيل على قدمك هو سبب شائع لكسور القدم.",
  //           "سقوط الجسم واصابته اصابه مبشره فيحدث كسر مكان  الإصابة ، أو اصابه غير مباشره مثل سقوط اللاعب واستناده على اليد فيحدث الكسر في الترقوة مثلا.",
  //           "نتيجة امراض وراثيه خلقيه في الطفل عند الولادة ،ترجع الى نقص في سلامه ونضوج الخلايا الأساسية التي تتكون منها العظام مما يترتب عليها ان تكون العظام هشة ضعيفة",
  //           "كسر مرضى نتيجة وجود مرض في العظم."
  //         ],
  //         "Symptoms": [
  //           "ألم شديد في مكان الكسر وخصوصا عند تحريك العضو المصاب .",
  //           "ورم يظهر تدريجيا نتيجة نزيف داخلي في مكان الكسر .",
  //           "فقد وظيفة العضو المكسور.",
  //           "خشخشة أي : سماع صوت غير طبيعي عند تحريك العظمة بعضا على بعض.",
  //           " تغير لون الجلد وميله إلى اللون الأورق نتيجة تجمع دموي حول الكسر.",
  //           "تشوه العضو المصاب أي اتخاذه شكلا غير عادي لاندماج الكسر.",
  //           "قصر في العظمة أو اعوجاجها"
  //         ],
  //         "firstAid": [
  //           "الامتناع عن تحريك العضو المصاب",
  //           "من حيث المبدأ يجب توخي الحذر في معاملة المصاب بالكسر، وذلك يتجنب استخدام العنف أو القوه( برفق وعناية ).",
  //           "تجنب إرجاع الكثير من غير المختصين ( الطبيب ( وإبقاء الكبير على ما وجد عليه ونقل المصاب إلى المستشفى بأسرع وقت.",
  //           "تجنب ربط جذع الطرف المصاب برباط ضاغط ، وذلك ربما يكون الكسر مشرشر أو التحام والتتام بطريقة خطاء – استخدام",
  //           "عدم خلع الحذاء إذا كانت الإصابة في القدم، حيث إن القدم ستكون أكثر ثباتا بوجود الحذاء.",
  //           "استخدام الجائر لتثبيت الطرف المكسور ، وفي حالة عدم الوجود يستخدم أي شيء ممكن استخدامه .",
  //           "علاج الصدمة العصبية والجراحية. ",
  //           "في حالة النزيف الدموي يجب إيقافه باستعمال رباط ضاغط فوق القماش المعقم .",
  //           "إعطاء المسكن، والتدفئة."
  //         ],
  //         "Treatment": [
  //           "الانقباضات العضلية الثابتة والعضو المصاب أثناء فترة التثبيت.",
  //           "الانقباضات العضلية المتحركة البعيدة للأجزاء البعيدة .",
  //           "التدليك بعيدا",
  //           "استخدام جلسات العلاج الكهربائي ( شورت واف الأشعة الحمراء ).",
  //           "التمرينات العلاجية وزيادة التدرج بعد فك الجنس في الماء الداعي.",
  //           "بعد العلاج يجب التأكد من صحة التئام الكسير بأخذ صورة بالأشعة (X-Ray) ."
  //         ]
  //       },
  //       "sprain": {
  //         "def": [
  //           '              "التواء المفصل هو شَدٌّ أو تَمَزُّق في الأربطة — أشرطة النسيج الليفي القوية التي تربط عظمتين مع بعضهما داخل مفصلك. يُعَدُّ الكاحل أكثر موضع عرضة للالتواء.وتشمل الرعاية الأولية: الراحة، والثلج، والضغط على الكاحل ورفعه. يُمكن علاج الالتواءات الخفيفة في المنزل بشكل ناجح. تتطلَّب الالتواءات الشديدة الجراحة غالبًا لإصلاح الأربطة الممزَّقة.فالفرق بين الالتواء والتمزُّق هو أن التمزُّق يصيب العضلات أو الحبل الليفي من الأنسجة التي تصل العضلات بالعظام، بينما الالتواء يصيب الشرائط القوية من الأنسجة الليفية التي تصل عظمتين معًا.",'
  //         ],
  //         "Symptoms": [
  //           "الألم",
  //           "تورم",
  //           "كدمات",
  //           "قدره محدوده علي تحريك المفصل المصاب",
  //           "سماع صوت (فرقعة) أو الشعور به في مفصلك وقت الإصابه "
  //         ],
  //         "reasons": [
  //           "الكاحل - المشي أو التمرين على سطح غير مستوٍ، والهبوط بشكل غريب من القفز",
  //           "الركبة - تدويرها حول محورها أثناء ممارسة نشاط رياضي",
  //           "المعصم - الهبوط على يد ممدودة خلال السقوط",
  //           "الإبهام - إصابة التزحلق على الجليد أو التمديد الزائد عن الحد عند لعب رياضات المضرب مثل التنس"
  //         ],
  //         "elweqaya": [
  //           "يمكن أن تساعد تمارين الإطالة (التمديد) والتقوية المنتظمة التي تمارسها أثناء ممارسة الرياضة أو اللياقة أو العمل، التي تُعَد جزءًا من برنامج التكيُّف البدني العام، في تقليل مخاطر التعرض للالتواءات. حاوِلْ أن تحافظ على لياقتك حتى تستطيع ممارسة رياضتك المفضلة، ولكن لا تحاوِلْ ممارسة رياضتك المفضلة لكي تصل إلى اللياقة. إذا كنتَ تعمل في وظيفة تتطلب مجهودًا بدنيًّا، فيمكن أن يساعدكَ التدريب المُنتظِم في منع حدوث الإصابات.",
  //         ],
  //         "3wamel_elkhatar": [
  //           "الظروف البيئية. تَزيد الأرضيات الزلقة وغير المستوية من فرص تعرضك لإصابة.",
  //           "الإرهاق. من غير المرجح أن توفر العضلات المجهدة دعمًا جيدًا لمفاصلك. وعندما تكون مرهقًا، يكون من الأرجح أيضًا تعرضك لمواقف قد تجهد أحد مفاصلك.",
  //           "المعدات غير الملائمة. إن الأحذية أو المعدات الرياضية الأخرى غير الملائمة أو التي لا يتم الاعتناء بها قد تزيد من خطر إصابتك بالتواء."
  //         ]
  //       },
  //       "dislocation": {
  //         "def": [
  //           "هو خروج أو انتقال اي من العظام المكونه للمفصل عن مكانها الطبيعي وبقائها خارج المفصل ولك نتيجة إصابة مباشر أو غير مباشره وغالبا ما يحدث تهتك وتلف في المحفظه الليفيه وتلف في المحفظه الليفيه والأنسجه المحيطه بالمفصل ويحدث انسكاب للسائل الزلالي ونزيف داخلي",
  //         ],
  //         "the_most": ["مفصل الكتف أكثرها", "مفصل المرفق", "مفصل الإبهام"],
  //         "dislocation_kind": [
  //           "الخلع الكامل : وفيه تنفصل جميع الأسطح المفصله المكونه للمفصل عن بعضها",
  //           "الخلع غير الكامل : وفيه تتباعد الأسطح وتتحرك بعيدا عن بعضها",
  //           "الخلع الكسر: يصاحبها كسر",
  //           "الخلع الرضي: يصاحبها رضي"
  //         ],
  //         "shoulder_dislocation": [
  //           "يعتبر مفصل الكتف أكثر المفاصل في الجسم عرضة للخلع نظرا لطبيعة تركيبه التشريحي ونسبة الإصابه  لباقي مفاصل الجسم-",
  //         ],
  //         "shoulder_dislocation_kind": [
  //           "الخلع الأمامي",
  //           "الخلع الخلفي",
  //           "الخلع أسفل الحفره العنابيه( الخلع تحت الإبط )"
  //         ],
  //         "front_dislocation": {
  //           "reasons": [
  //             "سبب مباشر : وهو الوقوع علي الكتف نفسه أو الضرب علي الكتف بحيث يكون اتجاه الضرب من الخلف للأمام",
  //             "سبب غير مباشر : وهو الوقوع أو الشد علي راحة اليد والذراع مفرودة وخلف الجسم"
  //           ],
  //           "Symptoms": [
  //             "ألم شديد مكان الخلع نتيجة لتمزق الأربطه والأنسجه المحيطه بالمفصل",
  //             "نزيف داخلي وانسكاب دموي وفي المحفظه الزلاليه مما يؤدي إلي الورم",
  //             "عدم قدرة المصاب علي وضع كف يد الكتف المصابه علي الكتف الآخر",
  //             "تشوه المفصل ومظاهر هذا التشوه هو خروج رأس عظم العضد من مكانه الطبيعي في المفصل واستقراره أمام الصدر من الجهه الوحشيه",
  //             "عدم القدره علي ضم الذراعين للجسم"
  //           ],
  //         },
  //         "back_dislocation": {
  //           //"def":[ "يعتبر أشدها وأخطرها"],
  //           "reasons": [
  //             "سبب مباشر : وهو السقوط علي الكتف أو الضرب المباشر عليه بحيث يكون باتجاه الضرب من الأمام إلي الخلف",
  //             "سبب غير مباشر : وهو السقوط أو السند علي راحة اليد والذراع مفروده وقريبه من الجسم اي بجانب الجسم"
  //           ],
  //           "Symptoms": [
  //             "نفس الأمامي ولكن التشوه هنا في مظهره يكون خروج رأس عظم العضد من مكانها الطبيعي في المفصل واستقرارها خلف عظم اللوح",
  //           ],
  //           "treatment": [
  //             "لا تعمل علاقه في هذا النوع من الخلع",
  //             "ينقل المصاب إلي المستشفي بأقصي سرعه",
  //             "عمل أشعه للتأكد من سلامة العظام ",
  //             "رد الخلع في العمليه",
  //             "تثبيت الكتف بالجبس حيث أن هذا النوع من الخلع يعتبر من أشدها خطوره",
  //             "التأهيل والتمرينات العلاجيه ولاعلاج الطبيبعي"
  //           ]
  //         },
  //         "under_dislocation": {
  //           // "def": "أيضا تعتبر من أخطر أنواع الخلع",
  //           "reasons": [
  //             "غير مباشر : السقوط علي راحة اليد والذراع مفروده وبعيده عن الجسم ",
  //           ],
  //           "Symptoms": [
  //             "بالإضافه للعلامات السابقه في الأمامي والخلفي أيضا يفقد الكتف الحركه وتكون ذراع المصاب معلقه لأعلي باستمرار",
  //           ],
  //           "treatment": ["نفس خطوات الخلفي ولا تعمل علاقه"]
  //         }
  //       },
  //       "SportsInjuries": [
  //         'الكدمات',
  //         "الكسور",
  //         "الإلتواء",
  //         " الخلع ",
  //         "التقلص العضلي",
  //         "التمزق العضلي"
  //       ],
  //       "Muscle tear": {
  //         "def": [
  //           "هو شد أو نزف الألياف العضلية، أو الأوتار، أو كيس المغلف للعضلة نتيجة جهد عضلي شديد وعنيف ومفاجئ بدرجة أكبر من قدرة العضلة على تحمل هذا الجهد"
  //         ],
  //         "reasons": [
  //           "الانقباض العضلي المفاجئ وهي غير مهياء لهذا الانقباض .",
  //           "المجهود العضلي الزائد(الإجهاد) الحمل أكبر من قدرة العضلة .",
  //           "عدم الاتزان في تدريب المجموعات العضلية .",
  //           " الإحماء غير كافي - زيادة لزوجة الوسط الداخلي للعضلة كما يسهل سرعة وصول الإشارات العصبية للعضلات المنفذة الحركة ،يقلل من الاحتكاك الداخلي للمفاصل وكذلك تحسين النعمة العضلية.",
  //           "عدم اكتمال والتماثل للشفاء من تمزق أو شد سابق .",
  //           "العمر ، كلما زاد عمر اللاعب زادت الإصابات بالشد والتمزق ."
  //         ],
  //         "Muscle tear levels": [
  //           "التمزق العضلي البسيط ( الشد العضلي ).",
  //           "التمزق العضلي الجزئي / وتحدث في الألياف العضلية في جسم أو بطن العضلة ، أو في العضلة ، أو عند المنشأ أوالاندغام  ",
  //           "منها يشعر بتقلص مكان . يفقد القدرة على الحركة كليا أو جزئياً بحسب كمية الألياف الممزقة ",
  //           "التمزق العضلي الكلي: وهو قطع كامل في الألياف للعضلة."
  //         ],
  //         "Symptoms": [
  //           "ألم مكان الإصابة ، تتوقف درجة هذا الألم على درجة الإصابة وعلى مكان الإصابة . يكون الألم بسيط كالشعور بنقر أو وحز خفيف في الشد.يكون الألم شديد كالشعور بقطع سكينة.",
  //           "في حالة التمزق الشديد من الممكن سماع صوت طرقعة في العضلة .",
  //           " عدم قدرة العضلات المصابة على أداء وظيفتها",
  //           "يحدث ورم مكان الإصابة .",
  //           "في حالة التمزق الكامل يمكن رؤية فجوة مكان الإصاب ",
  //           "انخفاض في مستوى الجلد."
  //         ],
  //         "FirstAid": [
  //           "التبريد",
  //           "الربط برباط ضاغط قبلها باستخدام الأشرطه اللاصقه بشكل عكسي أو طولي مع القطع من أسفل إلي أعلي",
  //           "الراحه",
  //           "راحه سلبيه للعضو المصاب من 3-4 أيام حسب حالة الإصابه",
  //           "إعطاء المسكن لتخفيف الألم"
  //         ],
  //         "treatment": [
  //           "الهدف من العلاج - المحافظة على التئام سليم ومتين للألياف العضلية المصابة .",
  //           "المحافظة على النغمة ومحاولة تنظيمها .",
  //           "تنمية التوافق العضلي والعصبي.",
  //           "اتزان العضلي للمجموعات العضلية العملة والمقابلة ."
  //         ]
  //       }
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print('Data posted successfully');
  //   } else {
  //     print('Failed to post data. Status code: ${response.statusCode}');
  //   }
  // }
  //
  // postData();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                // Locale('en'), // English
                Locale('ar'), // Spanish
              ],
              theme: ThemeData(brightness: Brightness.dark),
              debugShowCheckedModeBanner: false,
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return  WaitingScreen();
                  // }
                  if (snapshot.hasData) {
                    return SplashScreen();
                  } else {
                    return AuthScreen();
                  }
                },
              ));
        });
  }
}