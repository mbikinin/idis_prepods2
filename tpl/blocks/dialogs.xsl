<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

		
	<xsl:template name="feedback_dialog">
		<div id="feedback_dialog" class="dialog dialog_box box_shadow rounded">
			<a href="#" class="close">закрыть</a>
			<div class="logo"></div>
			<h1>Задать вопрос</h1>
			<div class="separator_line"></div>
			<form class="formfeedback">
			<div class="formDialog">
				<div class="item input">
					<label for="name">Имя<sup class="red">*</sup></label>
					<input type="text" name="name" id="feedback_name" />
				</div>
				<div class="item input">
					<label for="email">Телефон<sup class="red">*</sup></label>
					<input type="text" name="phone" id="feedback_phones" />
				</div>
				<div class="item input">
					<label for="email">E-mail<sup class="red">*</sup></label>
					<input type="text" name="mail" id="feedback_email" />
				</div>

				<div class="item input">
					<label for="name">Кому вопрос</label>
					<select name = "whom" id="feedback_whom">

						<option> специалисту по работе с клиентами</option>
						<option> специалисту по работе с партнерами</option>
						<option> администратору сайта</option>
					</select>
				</div>
				<div class="item textarea">
					<label for="message">Вопрос</label>
					<textarea name="message" id="feedback_message"></textarea>
				</div>
				<div class="item submit">
					<input type="button" name="send" value="Задать вопрос" id="feedback_submit" />
				</div>
			</div>
			</form>
			<div class="separator_line"></div>
			<div class="help">
				
        	</div>
		</div>
	</xsl:template>
	
	<xsl:template name="diller_dialog">
		<div id="diller_dialog" class="dialog dialog_box box_shadow rounded">
			<a href="#" class="close">закрыть</a>
			<div class="logo"></div>
			<h1>Стать дилером</h1>
			<div class="separator_line"></div>
			
			<form class="dilerfeedback">
			<div class="formDialog">
				<i>Я ознакомлен <a href="/page/view/of_dillers">с условиями</a> дилерства.</i><br/><br/>
				<div class="item input">
					<label for="name">Имя<sup class="red">*</sup></label>
					<input type="text" name="name" id="diller_name" />
				</div>
				<div class="item input">
					<label for="email">Организация<sup class="red">*</sup></label>
					<input type="text" name="organization" id="diller_organization" />
				</div>
				<div class="item input">
					<label for="email">Телефон<sup class="red">*</sup></label>
					<input type="text" name="phone" id="diller_phones" />
				</div>
				<div class="item input">
					<label for="email">E-mail<sup class="red">*</sup></label>
					<input type="text" name="mail" id="diller_email" />
				</div>

				<div class="item input">
					<label for="diller_city">Город<sup class="red">*</sup></label>
					<input type="text" name="city" id="diller_city" />
				</div>
				<div class="item submit">
					<input type="button" name="send" value="Стать дилером" id="diller_submit" />
				</div>
			</div>
			</form>
			<div class="separator_line"></div>
			<div class="help">
				
        	</div>
		</div>
	</xsl:template>
	
	
	<xsl:template name="probnik_dialog">
		<div id="probnik_dialog" class="dialog dialog_box box_shadow rounded">
			<a href="#" class="close">закрыть</a>
			<div class="logo"></div>
			<h1>Заказать пробник</h1>
			<div class="separator_line"></div>
			<form class="probnikform">
			<div class="formDialog">
				<div class="item input">
					<label for="probnik_name">Имя<sup class="red">*</sup></label>
					<input type="text" name="name" id="probnik_name" />
				</div>
				<div class="item input">
					<label for="probnik_organization">Организация<sup class="red">*</sup></label>
					<input type="text" name="organization" id="probnik_organization" />
				</div>
				<div class="item input">
					<label for="probnik_llc_address">Юр. адрес<sup class="red">*</sup></label>
					<input type="text" name="llc_address" id="probnik_llc_address" />
				</div>
				<div class="item input">
					<label for="probnik_inn_kpp">ИНН/КПП<sup class="red">*</sup></label>
					<input type="text" name="inn_kpp" id="probnik_inn_kpp" />
				</div>
				<div class="item input">
					<label for="probnik_inn_kpp">Адресс доставки<sup class="red">*</sup></label>
					<input type="text" name="address" id="probnik_address" />
				</div>					
				<div class="item input">
					<label for="probnik_phones">Телефон<sup class="red">*</sup></label>
					<input type="text" name="phone" id="probnik_phone" />
				</div>
				<div class="item input">
					<label for="probnik_email">E-mail<sup class="red">*</sup></label>
					<input type="text" name="mail" id="probnik_email" />
				</div>
				
				<div class="item input">
					<label for="probnik_message">Какой товар Вас интересует?<sup class="red">*</sup></label>
					<textarea type="text" name="message" id="probnik_message" ></textarea>
				</div>
				
				<div class="item submit">
					<input type="button" name="send" value="Заказать пробник" id="probnik_submit" />
				</div>
			</div>
			</form>
			<div class="separator_line"></div>
			<div class="help">

        	</div>
		</div>
	</xsl:template>
	<xsl:template name="ecsclusive_dialog">
		<div id="ecsclusive_dialog" class="dialog dialog_box box_shadow rounded">
			<a href="#" class="close">закрыть</a>
			<div class="logo"></div>
			<h1>Узнать цену</h1>
			<div class="separator_line"></div>
			<form class="ecsclusiveform">
			<div class="formDialog">
				<div class="item input">
					<label for="probnik_name">Имя<sup class="red">*</sup></label>
					<input type="text" name="name" id="ecsclusive_name" />
				</div>
				<div class="item input">
					<label for="probnik_organization">Организация<sup class="red">*</sup></label>
					<input type="text" name="organization" id="ecsclusive_organization" />
				</div>
				<div class="item input">
					<label for="probnik_llc_address">Город<sup class="red">*</sup></label>
					<input type="text" name="llc_address" id="ecsclusive_llc_address" />
				</div>					
				<div class="item input">
					<label for="probnik_phones">Телефон<sup class="red">*</sup></label>
					<input type="text" name="phone" id="ecsclusive_phone" />
				</div>
				<div class="item input">
					<label for="probnik_email">E-mail<sup class="red">*</sup></label>
					<input type="text" name="mail" id="ecsclusive_email" />
				</div>
				
				<div class="item input">
					<label for="probnik_message">Какой товар Вас интересует?<sup class="red">*</sup></label>
					<textarea type="text" name="message" id="ecsclusive_message" >
					
					</textarea>
				</div>
				
				<div class="item submit">
					<input type="button" name="send" value="Узнать цену" id="ecsclusive_submit" />
				</div>
			</div>
			</form>
			<div class="separator_line"></div>
			<div class="help">

        	</div>
		</div>
	</xsl:template>
	
	
	<xsl:template name="order_dialog">
		<div id="order_dialog" class="dialog dialog_box box_shadow rounded">
			<a href="#" class="close">закрыть</a>
			<div class="logo"></div>
			<h1>Оформление заказа</h1>
			<div class="separator_line"></div>
			<form class="orderform">
			<div class="formDialog">
				<div class="item input">
					<label for="order_name">Имя<sup class="red">*</sup></label>
					<input type="text" name="name" id="order_name" />
				</div>
				<div class="item input">
					<label for="order_inn_kpp">Адресс доставки<sup class="red">*</sup></label>
					<input type="text" name="address" id="order_address" />
				</div>					
				<div class="item input">
					<label for="order_phones">Телефон<sup class="red">*</sup></label>
					<input type="text" name="phone" id="order_phone" />
				</div>
				<div class="item input">
					<label for="order_email">E-mail<sup class="red">*</sup></label>
					<input type="text" name="mail" id="order_email" />
				</div>
				<div class="item submit">
					<input type="button" name="send" value="Оформить заказ" id="order_submit" />
				</div>
			</div>
			</form>
			<div class="separator_line"></div>
			<div class="help">
				
        	</div>
		</div>
	</xsl:template>
	
	


</xsl:stylesheet>