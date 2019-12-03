# UsersApp

Приложение основано на архитектуре MVC, где небольшие компоненты работают в связи View-Model.

# Страница списка пользователей

Главная страница - UsersListViewController. Он содержит в себе экземпляр класса UITableView с кастомными ячейками. У каждой ячейки (UserListCell) есть своя модель данных (UserListCellVM). В модели хранится информация о пользователе.

# Страница создания/редактирования пользователя



# Network layer

Была создана некая прослойка для работы с фреймоврком Alamofire под названием RequestService для вызова запросов и получения ответов, которые декодятся в Resource. Запрос конифгурируется с помощью класса UserAction и протокола APIAction.

# Helpers

Были созданы "классы-помощники" EmailValidator и KeybopardHelper. Первый отвечает за валидацию и возвращения результата валидации, а второй - отдельный класс для обработки ивентов клавиатуры, который передает информацию через closure.

# Models

В проекте есть 3 модельки - User, NewUser и CustomError.

User - он конформит протокол Codable и создает модель пользователя, когда Мы получаем о нем ифнормацию после запроса

NewUser - используется при создании/редактировании пользователя. Является укороченным вариантом модельки User для более удобного использования.

# View

TextField - это наследник MFTextField (фреймворк MaterialTextField), который представляет из себя поле с анимациями. В нем некие кастомные конфигурации по части UI.

LoadingView - кастомный View, который содержит в себе ActivityIndicator. Используется для показа на экране во время загрузки/отправки данных.

# Cells

В проект существует одна кастомная ячейка - UserListCell, которая конформит протокол NibReusable (фреймворк Reusable), который облегчает для нас процесс реюза ячейки. Объект класса UserListCell используется для показа информации о пользователе в объекте класса UITableView на главной странице.

Он имеет в себе доступную извне переменную viewModel типа UserListCellVM, при установке которового в его didSet вызывается функция для конфигурации контента.

# Kingfisher

В проекте использован популярный фреймворк Kingfisher для работы с картинками. Так же есть расширение UIImageView+, где методы данного фреймоврка обернуты для избежания дубликации кода и читаемости.

# Другое

Используется фреймворка SwiftGen, который с помощью скрипта генерирует файлы Assets и Localizations, для более читаемого доступа к файлами и текстам.

# О проблемах во время реализации

Так как нет предоставленного способа загрузки картинок, логическая часть, связанная с установкой/изменением аватара у пользователя отсутствует, можно только визуально увидеть результат работы с UIImagePickerController. Логическая часть отстутсвует ввиду нехватки информации.
