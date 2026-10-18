#import "/main.typ": theme
#set document(
  title: "Главная | snlx.net",
  description: "Я Александр, веб-разработчик с небольшим уклоном в робототехнику; это мой сайт",
)
#show: theme("/", "/ru", "ru/index.svg", "dark", 1018)

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

