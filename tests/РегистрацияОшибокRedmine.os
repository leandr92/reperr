#Использовать "../src/model"

// BSLLS:UnusedParameters-off
Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
// BSLLS:UnusedParameters-on
	
	ВсеТесты = Новый Массив;
	
	ВсеТесты.Добавить("ТестДолжен_СформироватьТелоЗапросаRedmine");

	Возврат ВсеТесты;
	
КонецФункции

Процедура ПередЗапускомТеста() Экспорт
	
	УстановитьТекущийКаталог(ТекущийСценарий().Каталог);
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
КонецПроцедуры

Процедура ТестДолжен_СформироватьТелоЗапросаRedmine() Экспорт
	
	ПровайдерИнтеграцииRedmine = Новый ПровайдерИнтеграцииRedmine()
												.URLRedmine("url")
												.КлючAPI("APIKey")
												.ИдПроекта("project-id")
												.ИдТрекера("1")
												.ИдПриоритета("1")
												.ИдСтатуса("1")
												.Тема("topic")
												.КоличествоЧасов("1");

	ФайловоеХранилище = Новый ФайловоеХранилище("../features/fixtures/data");

	ДанныеОтчетаОбОшибке = ФайловоеХранилище.ПолучитьДанныеОтчетаОбОшибке("61001a5e-09d5-47b8-bf19-e7672eda10e5");
	Результат = ПровайдерИнтеграцииRedmine.СформироватьТелоЗапроса(ДанныеОтчетаОбОшибке);
	
	КаталогСценария = ТекущийСценарий().Каталог;
	ЧтениеТекста = Новый ЧтениеТекста("../features/fixtures/requestBodyRedmine.json", "utf-8");
	Эталон = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();
	
	Ожидаем.Что(Результат).Равно(Эталон);
	
КонецПроцедуры
