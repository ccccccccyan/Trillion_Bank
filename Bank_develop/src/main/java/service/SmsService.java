package service;

import java.util.Random;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

public class SmsService {

	public SmsService(String calling_tel, String receipt_tel, int sixNumber) {
		/*aaa
			NurigoApp.INSTANCE.initialize(...) : CoolSMS의 NurigoApp 객체를 사용하여 API 키, API 시크릿 키, API 엔드포인트 URL을 설정하여 초기화
			DefaultMessageService : CoolSMS에서 제공하는 기본 메시지 서비스 객체
		 */																	
		DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize("NCSJUIBKK52HKLAG", "R43FXXYBBPFUOC0UMELPV9I1ZCEXQVKW", "https://api.coolsms.co.kr"); // api 키, api 시크릿 키, api url
		// Message 패키지가 중복될 경우 net.nurigo.sdk.message.model.Message로 치환하여 주세요
		
		/*
			Message: CoolSMS에서 제공하는 메시지 객체로, SMS 발송에 필요한 정보를 설정합니다.
			setFrom(): 발신 번호를 설정합니다. CoolSMS 계정에서 사전 등록한 발신 번호를 입력해야 합니다.
			setTo(): 수신 번호를 설정합니다. SMS를 받을 대상의 전화번호를 입력합니다.
			setText(): 발송할 메시지 내용을 설정합니다. 한글 45자 또는 영문 90자까지 입력할 수 있습니다.
		 */
		Message message = new Message();
		message.setFrom(calling_tel); // 계정에서 등록한 발신번호 입력
		message.setTo(receipt_tel); // 수신번호 입력
		message.setText("Trillion Bank || 인증번호는 " + sixNumber + "입니다."); // SMS는 한글 45자, 영자 90자까지 입력할 수 있습니다.
		
		try {
			// send 메소드로 ArrayList<Message> 객체를 넣어도 동작합니다!
			messageService.send(message);
		} catch (NurigoMessageNotReceivedException exception) {
			// 발송에 실패한 메시지 목록을 확인할 수 있습니다!
			System.out.println(exception.getFailedMessageList());
			System.out.println(exception.getMessage());
		} catch (Exception exception) {
			System.out.println(exception.getMessage());
		}
	}
	
}
