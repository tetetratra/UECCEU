// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import 'bootstrap'
import '../src/application.scss'



// https://www.tam-tam.co.jp/tipsnote/javascript/post11315.html を参考にした
var class_names = [
  'course_title_japanese',
  'course_title_english',
  'code',
  'year_offerd',
  'semester_offerd',
  'faculty_offering_the_course',
  'credits',
  'category',
  'cluster_and_department',
  'lecturer',
  'course_website'
]


// 全部マッチ(空白は無視) => 表示
// input時に、全部OKにする。
// で、全部のinputを順に処理。
// OKの中からマッチしたものだけを絞るのをclass_namesごとにやる
class_names.forEach(
  class_name => {
    $(
      function() {
        $('form.search_form.' + class_name + '> input').on(
          'input',
          function(){
            $('table tr:not(.header_row)').each( // 一旦全部OKにする
              function(index) { // thisの束縛はアロー関数じゃできないらしい。ここをアロー関数にするとformonのメソッドに対してのthisになってしまう
                $(this).removeClass('d-none')
              }
            )
            class_names.forEach(
              function(class_name2) {
                var val = $('form.search_form.' + class_name2 + '> input').val()
                if(val.match(/^\s+$/)){return}
                var reg = new RegExp(val)

                $('table tr:not(.header_row):not(.d-none) > td.' + class_name2).each(
                  function(index2) {
                    if (!$(this).text().match(reg)) { // マッチしなかったらnoneにする
                      $(this).parent().addClass('d-none')
                    }
                  }
                )
              }
            )
          }
        )
      }
    )

  }
)


$(
  function() {
    $('form.search_form').submit( function() {return false} )
  }
)



// class_names.forEach(
//   class_name => {
//     $(
//       function() {
//         $('form.search_form.' + class_name + '> input').on(
//           'input',
//           function(){
//             var searchText = $(this).val()
//             var targetText
//             $('table td.' + class_name).each(function(){
//               targetText = $(this).text()
//               if (targetText.indexOf(searchText) != -1) {
//                 $(this).parent().removeClass('d-none')
//               } else {
//                 $(this).parent().addClass('d-none')
//               }
//             })
//           }
//         )
//       }
//     )

//   }
// )
