#import "@preview/catppuccin:1.1.0": catppuccin, flavors, set-code-theme
#import "/main.typ": theme
#set document(title: [Главная | snlx.net])
#show: catppuccin.with(flavors.mocha)
#show: theme("/", "ru/index.svg", "dark", 1018)

#html.style("footer, .squiggles:last-of-type { display: none; }")

= Проекты

- #link("/ru/yap")[yap] --- движок презентаций и интерактивных книг (есть #link("https://typst.app/universe/package/yap")[интеграция для Typst])
  - сейчас его переписываю, считайте бетой
- #link("/ru/dyno")[dyno] --- динамический рантайм для Typst
- #link("/ru/eqrun")[eqrun] --- решалка блоков уравнений в Typst
- #link("/ru/backbone")[backbone], делает из андроида браузер + termux + BLE апи

= Статьи

- #link("/магниты")[Магниты] --- как устроены электродвигатели (в процессе написания)

= Контакты
- #link("mailto:alexanderthestudent@yandex.ru")[Почта]

