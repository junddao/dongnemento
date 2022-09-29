import 'repo_interface.dart';

/*============= 아래는 로컬 에러 응답코드 (해당 에러발생시 자체 로컬에 확인 바람) ======================*/
class EmptyJWT extends InternalFailure {
  EmptyJWT() : super("Empty JWT");
}

class InvalidList extends InternalFailure {
  InvalidList() : super("Invalid input list");
}

class FailedHost extends InternalFailure {
  FailedHost() : super("인터넷 연결 후 재시도하여 주세요.");
}

/*============= 아래는 서베 에러 응답코드 (해당 에러발생시 서버에서 확인 바람) ======================*/
// ignore: camel_case_types
class CATEGORY_DOES_NOT_EXIST extends ServerFailure {
  CATEGORY_DOES_NOT_EXIST() : super("카테고리가 존재하지 않습니다.");
}

// ignore: camel_case_types
class LINK_MEMBER_HAS_BEEN_ENDED_ALREADY extends ServerFailure {
  LINK_MEMBER_HAS_BEEN_ENDED_ALREADY() : super("해당회원은 이미 종료회원입니다.");
}

// ignore: camel_case_types
class LINK_MEMBER_IS_NOT_ENDED extends ServerFailure {
  LINK_MEMBER_IS_NOT_ENDED() : super("종료회원으로 이동되지 않았습니다.");
}

// ignore: camel_case_types
class ORDER_STOCK_DOES_NOT_EXIST extends ServerFailure {
  ORDER_STOCK_DOES_NOT_EXIST() : super("주문재고가 존재하지 않습니다.");
}

// ignore: camel_case_types
class ORDER_STOCK_HAS_BEEN_CANCELED extends ServerFailure {
  ORDER_STOCK_HAS_BEEN_CANCELED() : super("주문재고가 취소되었습니다.");
}

// ignore: camel_case_types
class ORDER_STOCK_HAS_DEACTIVE_PRODUCT extends ServerFailure {
  ORDER_STOCK_HAS_DEACTIVE_PRODUCT() : super("상품의 주문재고가 비활성화 되었습니다.");
}

// ignore: camel_case_types
class ORDER_STOCK_IS_NOT_VALID extends ServerFailure {
  ORDER_STOCK_IS_NOT_VALID() : super("주문재고가 유효하지 않습니다.");
}

// ignore: camel_case_types
class ORDER_STOCK_PRODUCT_TYPE_IS_NOT_CLASS extends ServerFailure {
  ORDER_STOCK_PRODUCT_TYPE_IS_NOT_CLASS() : super("주문한 재고의 상품 타입이 수업이 아닙니다.");
}

// ignore: camel_case_types
class ORDER_STOCK_QUANTITY_MUST_BE_GREATER_THAN_OR_EQUAL_TO_1
    extends ServerFailure {
  ORDER_STOCK_QUANTITY_MUST_BE_GREATER_THAN_OR_EQUAL_TO_1()
      : super("주문재고의 양은 1보다 크거나 같아야 합니다.");
}

// ignore: camel_case_types
class PARENT_PRODUCT_CATEGORY_CANNOT_HAVE_CHILDREN extends ServerFailure {
  PARENT_PRODUCT_CATEGORY_CANNOT_HAVE_CHILDREN()
      : super("선택된 보호자 상품 카테고리는 피보호자 카테고리를 가질수 없습니다.");
}

// ignore: camel_case_types
class PARENT_PRODUCT_CATEGORY_DEPTH_IS_LAST_DEPTH_4 extends ServerFailure {
  PARENT_PRODUCT_CATEGORY_DEPTH_IS_LAST_DEPTH_4()
      : super("선택된 부모 상품 카테고리는 4뎁스 카테고리 입니다.");
}

// ignore: camel_case_types
class PARENT_PRODUCT_CATEGORY_DOES_NOT_EXIST extends ServerFailure {
  PARENT_PRODUCT_CATEGORY_DOES_NOT_EXIST() : super("부모 상품 카테고리가 존재하지 않습니다.");
}

// ignore: camel_case_types
class CANNOT_DELETE_PRODUCT_CATEGORY_HAS_CHILDREN extends ServerFailure {
  CANNOT_DELETE_PRODUCT_CATEGORY_HAS_CHILDREN()
      : super("자녀 카테고리가 존재하여 해당 상품 카테고리를 삭제할 수 없습니다.");
}

// ignore: camel_case_types
class INVALID_INPUT_ROUND extends ServerFailure {
  INVALID_INPUT_ROUND() : super("입력된 값이 정수값이 아닙니다.");
}

// ignore: camel_case_types
class ORDER_STOCK_HAS_UNKNOWN_PRODUCT extends ServerFailure {
  ORDER_STOCK_HAS_UNKNOWN_PRODUCT() : super("주문 (재고)에 존재하지 않는 상품이 포함되어 있습니다.");
}

// ignore: camel_case_types
class SERVICE_LINK_DOES_EXIST extends ServerFailure {
  SERVICE_LINK_DOES_EXIST() : super("해당 서비스에 속한 링크가 존재합니다.");
}

// ignore: camel_case_types
class LINK_MEMBER_TO_LINK_DOES_NOT_EXIST extends ServerFailure {
  LINK_MEMBER_TO_LINK_DOES_NOT_EXIST() : super("링크로 보낼 링크회원이 존재하지 않습니다.");
}

// ignore: camel_case_types
class INPUT_SERVICE_IS_NOT_VALID extends ServerFailure {
  INPUT_SERVICE_IS_NOT_VALID() : super("입력된 서비스가 유효하지 않습니다.");
}

// ignore: camel_case_types
class ACCOUNT_HAS_BEEN_JOINED_LINK_ALREADY extends ServerFailure {
  ACCOUNT_HAS_BEEN_JOINED_LINK_ALREADY() : super("이미 링크에 등록된 회원입니다.");
}

// ignore: camel_case_types
class ACCOUNTS_TO_INVITE_DO_NOT_EXIST extends ServerFailure {
  ACCOUNTS_TO_INVITE_DO_NOT_EXIST() : super("초대되지 않은 회원입니다.");
}

// ignore: camel_case_types
class CANNOT_CHANGE_LINK_MEMBER extends ServerFailure {
  CANNOT_CHANGE_LINK_MEMBER() : super("본 링크 회원을 변경할 수 없습니다.");
}

// ignore: camel_case_types
class CANNOT_CHANGE_LINK_MEMBER_ROLE extends ServerFailure {
  CANNOT_CHANGE_LINK_MEMBER_ROLE() : super("본 링크 회원의 운영권한을 변경할 수 없습니다.");
}

// ignore: camel_case_types
class CLASS_DOES_NOT_EXIST extends ServerFailure {
  CLASS_DOES_NOT_EXIST() : super("수업이 존재하지 않습니다.");
}

// ignore: camel_case_types
class COULD_NOT_ACCEPT_LINK_INVITATION_FOR_CURRENT_USER extends ServerFailure {
  COULD_NOT_ACCEPT_LINK_INVITATION_FOR_CURRENT_USER()
      : super("현재 사용자의 초대를 수락할 수 없습니다.");
}

// ignore: camel_case_types
class COULD_NOT_DECLINE_LINK_INVITATION_FOR_CURRENT_USER extends ServerFailure {
  COULD_NOT_DECLINE_LINK_INVITATION_FOR_CURRENT_USER()
      : super("현재 사용자의 초대를 거부할 수 없습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_MEMBER extends ServerFailure {
  CURRENT_USER_IS_NOT_MEMBER() : super("현재 사용자는 맴버가 아닙니다.");
}

// ignore: camel_case_types
class CURRENT_USER_LINK_MEMBER_ALREADY_LINKED extends ServerFailure {
  CURRENT_USER_LINK_MEMBER_ALREADY_LINKED() : super("본 링크에 이미 등록되어 있는 회원입니다.");
}

// ignore: camel_case_types
class EMAIL_TEMPLATE_DOES_NOT_EXIST extends ServerFailure {
  EMAIL_TEMPLATE_DOES_NOT_EXIST() : super("이메일 템플릿이 없습니다.");
}

// ignore: camel_case_types
class IAMPORT_PAYMENT_CANCEL_ERROR extends ServerFailure {
  IAMPORT_PAYMENT_CANCEL_ERROR() : super("결제 취소에 실패하였습니다.");
}

// ignore: camel_case_types
class IAMPORT_PAYMENT_DOES_NOT_EXIST extends ServerFailure {
  IAMPORT_PAYMENT_DOES_NOT_EXIST() : super("결제 내역이 없습니다.");
}

// ignore: camel_case_types
class IAMPORT_PAYMENT_HAS_CANCELED_ALREADY extends ServerFailure {
  IAMPORT_PAYMENT_HAS_CANCELED_ALREADY() : super("이미 취소된 결제입니다.");
}

// ignore: camel_case_types
class IAMPORT_PAYMENT_STATUS_IS_NOT_CANCELED extends ServerFailure {
  IAMPORT_PAYMENT_STATUS_IS_NOT_CANCELED() : super("결제상태가 취소된 결제가 아닙니다.");
}

// ignore: camel_case_types
class IAMPORT_PAYMENT_STATUS_IS_NOT_PAID extends ServerFailure {
  IAMPORT_PAYMENT_STATUS_IS_NOT_PAID() : super("결제상태가 지불된 결제가 아닙니다.");
}

// ignore: camel_case_types
class INPUT_ADDITIONAL_FIELDS_IS_NOT_VALID extends ServerFailure {
  INPUT_ADDITIONAL_FIELDS_IS_NOT_VALID() : super("입력된 추가 필드가 유효하지 않습니다.");
}

// ignore: camel_case_types
class INPUT_CUSTOM_FIELDS_IS_NOT_VALID extends ServerFailure {
  INPUT_CUSTOM_FIELDS_IS_NOT_VALID() : super("입력된 고객 필드가 유효하지 않습니다.");
}

// ignore: camel_case_types
class INPUT_MEMBER_ADMIN_FIELDS_IS_NOT_VALID extends ServerFailure {
  INPUT_MEMBER_ADMIN_FIELDS_IS_NOT_VALID()
      : super("입력된 운영자 회원의 필드가 유효하지 않습니다.");
}

// ignore: camel_case_types
class INPUT_MEMBER_CUSTOMER_FIELDS_IS_NOT_VALID extends ServerFailure {
  INPUT_MEMBER_CUSTOMER_FIELDS_IS_NOT_VALID()
      : super("입력된 이용자 회원의 필드가 유효하지 않습니다.");
}

// ignore: camel_case_types
class INPUT_MEMBER_PARTNER_FIELDS_IS_NOT_VALID extends ServerFailure {
  INPUT_MEMBER_PARTNER_FIELDS_IS_NOT_VALID() : super("입력된 학부모 필드가 유효하지 않습니다.");
}

// ignore: camel_case_types
class INPUT_MEMBER_STAFF_FIELDS_IS_NOT_VALID extends ServerFailure {
  INPUT_MEMBER_STAFF_FIELDS_IS_NOT_VALID() : super("입력된 운영진 필드가 유효하지 않습니다.");
}

// ignore: camel_case_types
class LINK_AUTHOR_MEMBER_DOES_NOT_EXIST extends ServerFailure {
  LINK_AUTHOR_MEMBER_DOES_NOT_EXIST() : super("링크 개설자가 존재하지 않습니다.");
}

// ignore: camel_case_types
class LINK_HAS_BEEN_PUBLISHED_ALREADY extends ServerFailure {
  LINK_HAS_BEEN_PUBLISHED_ALREADY() : super("이미 개설된 링크입니다.");
}

// ignore: camel_case_types
class LINK_INVITATION_FOR_CURRENT_USER_DOES_NOT_EXIST extends ServerFailure {
  LINK_INVITATION_FOR_CURRENT_USER_DOES_NOT_EXIST()
      : super("현 이용자의 링크 초대장이 존재하지 않습니다.");
}

// ignore: camel_case_types
class LINK_INVITATION_TO_EMAIL_ALREADY_EXISTS extends ServerFailure {
  LINK_INVITATION_TO_EMAIL_ALREADY_EXISTS() : super("이메일 초대장이 이미 존재합니다.");
}

// ignore: camel_case_types
class LINK_INVITATION_TO_SMS_ALREADY_EXISTS extends ServerFailure {
  LINK_INVITATION_TO_SMS_ALREADY_EXISTS() : super("SMS 초대장이 이미 존재합니다.");
}

// ignore: camel_case_types
class LINK_IS_NOT_PUBLISHED extends ServerFailure {
  LINK_IS_NOT_PUBLISHED() : super("링크가 생성되지 않았습니다.");
}

// ignore: camel_case_types
class LINK_MASTER_MEMBER_DOES_NOT_EXIST extends ServerFailure {
  LINK_MASTER_MEMBER_DOES_NOT_EXIST() : super("링크의 운영자가 존재하지 않습니다.");
}

// ignore: camel_case_types
class LINK_MEMBER_ALREADY_LINKED extends ServerFailure {
  LINK_MEMBER_ALREADY_LINKED() : super("링크 유저가 이미 등록되어 있습니다.");
}

// ignore: camel_case_types
class LINK_MEMBER_HAS_MANAGING_PRODUCT extends ServerFailure {
  LINK_MEMBER_HAS_MANAGING_PRODUCT() : super("현 링크 유저는 상품 매니저로 등록되어 있습니다.");
}

// ignore: camel_case_types
class LINK_MEMBER_IS_NOT_ADMIN extends ServerFailure {
  LINK_MEMBER_IS_NOT_ADMIN() : super("현 링크유저는 운영자가 아닙니다.");
}

// ignore: camel_case_types
class LINK_MEMBER_IS_NOT_MANAGEABLE extends ServerFailure {
  LINK_MEMBER_IS_NOT_MANAGEABLE() : super("현 링크 유저는 매니저가 될수 없습니다.");
}

// ignore: camel_case_types
class LINK_MUST_BE_ACCEPTED_BY_ADMIN extends ServerFailure {
  LINK_MUST_BE_ACCEPTED_BY_ADMIN() : super("본 링크는 관리자의 허가가 필요합니다.");
}

// ignore: camel_case_types
class MY_LINK_INVITATION_DOES_NOT_EXIST extends ServerFailure {
  MY_LINK_INVITATION_DOES_NOT_EXIST() : super("나의 링크 초대장이 존재하지 않습니다.");
}

// ignore: camel_case_types
class ORDER_CANCEL_ERROR extends ServerFailure {
  ORDER_CANCEL_ERROR() : super("주문 취소에 실패하였습니다.");
}

// ignore: camel_case_types
class ORDER_DOES_NOT_EXIST extends ServerFailure {
  ORDER_DOES_NOT_EXIST() : super("주문이 존재하지 않습니다.");
}

// ignore: camel_case_types
class ORDER_HAS_BEEN_CANCELED extends ServerFailure {
  ORDER_HAS_BEEN_CANCELED() : super("주문은 이미 취소되었습니다.");
}

// ignore: camel_case_types
class ORDER_STATUS_IS_NOT_REMITTED extends ServerFailure {
  ORDER_STATUS_IS_NOT_REMITTED() : super("주문이 송금상태가 아닙니다.");
}

// ignore: camel_case_types
class ORDER_STATUS_IS_NOT_VALID extends ServerFailure {
  ORDER_STATUS_IS_NOT_VALID() : super("주문이 유효하지 않습니다.");
}

// ignore: camel_case_types
class PAID_AMOUNT_IS_NOT_VALID extends ServerFailure {
  PAID_AMOUNT_IS_NOT_VALID() : super("결제 금액이 유효하지 않습니다.");
}

// ignore: camel_case_types
class PAYMENT_ALREADY_EXISTS extends ServerFailure {
  PAYMENT_ALREADY_EXISTS() : super("이미 지불되었습니다.");
}

// ignore: camel_case_types
class PAYMENT_CANCEL_ERROR extends ServerFailure {
  PAYMENT_CANCEL_ERROR() : super("지불 취소에 실패하였습니다.");
}

// ignore: camel_case_types
class PAYMENT_DOES_NOT_EXIST extends ServerFailure {
  PAYMENT_DOES_NOT_EXIST() : super("지불되지 않았습니다.");
}

// ignore: camel_case_types
class PAYMENT_STATUS_IS_NOT_PAID extends ServerFailure {
  PAYMENT_STATUS_IS_NOT_PAID() : super("지불되지 않은 상태입니다.");
}

// ignore: camel_case_types
class PRODUCT_HAS_BEEN_PUBLISHED_ALREADY extends ServerFailure {
  PRODUCT_HAS_BEEN_PUBLISHED_ALREADY() : super("상품이 이미 존재합니다.");
}

// ignore: camel_case_types
class PRODUCT_IS_NOT_PUBLISHED extends ServerFailure {
  PRODUCT_IS_NOT_PUBLISHED() : super("상품이 생성되지 않았습니다.");
}

// ignore: camel_case_types
class PRODUCT_IS_NOT_UNPUBLISHED extends ServerFailure {
  PRODUCT_IS_NOT_UNPUBLISHED() : super("상품 생성이 취소되지 않았습니다.");
}

// ignore: camel_case_types
class PRODUCT_IS_UNPUBLISHED extends ServerFailure {
  PRODUCT_IS_UNPUBLISHED() : super("상품이 미게시 상태입니다.");
}

// ignore: camel_case_types
class PRODUCT_TYPE_IS_NOT_CLASS extends ServerFailure {
  PRODUCT_TYPE_IS_NOT_CLASS() : super("상품 타입이 수업타입이 아닙니다.");
}

// ignore: camel_case_types
class SEND_INVITATION_BY_EMAIL_FAILED extends ServerFailure {
  SEND_INVITATION_BY_EMAIL_FAILED() : super("이메일 초대 전송이 실패하였습니다.");
}

// ignore: camel_case_types
class SEND_INVITATION_BY_EMAIL_TEMPLATE_FAILED extends ServerFailure {
  SEND_INVITATION_BY_EMAIL_TEMPLATE_FAILED() : super("이메일 초대 템플릿 생성이 실패하였습니다.");
}

// ignore: camel_case_types
class SEND_SMS_FAILED extends ServerFailure {
  SEND_SMS_FAILED() : super("SMS 초대전송이 실패하였습니다.");
}

// ignore: camel_case_types
class SERVICE_DESIGN_CUSTOMER_FORM_IS_NOT_VALID extends ServerFailure {
  SERVICE_DESIGN_CUSTOMER_FORM_IS_NOT_VALID()
      : super("서비스 설계의 고객 유형이 유효하지 않습니다.");
}

// ignore: camel_case_types
class SERVICE_DESIGN_LINK_FORM_IS_NOT_VALID extends ServerFailure {
  SERVICE_DESIGN_LINK_FORM_IS_NOT_VALID() : super("서비스 설계의 링크 유형이 유효하지 않습니다.");
}

// ignore: camel_case_types
class SERVICE_DOES_NOT_EXIST extends ServerFailure {
  SERVICE_DOES_NOT_EXIST() : super("해당 서비스가 존재하지 않습니다.");
}

// ignore: camel_case_types
class SERVICE_FIELD_DOES_NOT_EXIST extends ServerFailure {
  SERVICE_FIELD_DOES_NOT_EXIST() : super("해당 서비스 필드가 존재하지 않습니다.");
}

// ignore: camel_case_types
class SERVICE_FIELD_HAS_PUBLISHED_SERVICE extends ServerFailure {
  SERVICE_FIELD_HAS_PUBLISHED_SERVICE() : super("이미 생성된 서비스 필드입니다.");
}

// ignore: camel_case_types
class SERVICE_FIELD_HAS_SERVICE_HAS_EVER_PUBLISHED extends ServerFailure {
  SERVICE_FIELD_HAS_SERVICE_HAS_EVER_PUBLISHED()
      : super("해당 서비스 필드는 이미 생성되었습니다.");
}

// ignore: camel_case_types
class SERVICE_FIELD_NAME_HAS_ALREADY_BEEN_USED extends ServerFailure {
  SERVICE_FIELD_NAME_HAS_ALREADY_BEEN_USED() : super("이미 사용중인 서비스 명입니다.");
}

// ignore: camel_case_types
class SERVICE_HAS_BEEN_PUBLISHED_ALREADY extends ServerFailure {
  SERVICE_HAS_BEEN_PUBLISHED_ALREADY() : super("서비스는 이미 생성되었습니다.");
}

// ignore: camel_case_types
class SERVICE_HAS_EVER_BEEN_PUBLISHED_ALREADY extends ServerFailure {
  SERVICE_HAS_EVER_BEEN_PUBLISHED_ALREADY() : super("해당 서비스는 이미 생성되었습니다.");
}

// ignore: camel_case_types
class SERVICE_IS_NOT_DESIGNED extends ServerFailure {
  SERVICE_IS_NOT_DESIGNED() : super("서비스가 설계되지 않았습니다.");
}

// ignore: camel_case_types
class SERVICE_IS_NOT_PUBLISHED extends ServerFailure {
  SERVICE_IS_NOT_PUBLISHED() : super("서비스가 생성되지 않았습니다.");
}

// ignore: camel_case_types
class SERVICE_IS_NOT_UNPUBLISHED extends ServerFailure {
  SERVICE_IS_NOT_UNPUBLISHED() : super("서비스가 생성취소되지 않았습니다.");
}

// ignore: camel_case_types
class SERVICE_NAME_HAS_ALREADY_BEEN_USED extends ServerFailure {
  SERVICE_NAME_HAS_ALREADY_BEEN_USED() : super("해당 서비스명이 이미 사용중입니다.");
}

// ignore: camel_case_types
class SOME_STUDENTS_DO_NOT_EXIST extends ServerFailure {
  SOME_STUDENTS_DO_NOT_EXIST() : super("일부 학생이 존재하지 않습니다.");
}

// ignore: camel_case_types
class STUDENT_ALREADY_EXIST extends ServerFailure {
  STUDENT_ALREADY_EXIST() : super("학생이 이미 존재합니다.");
}

// ignore: camel_case_types
class STUDENT_DOES_NOT_EXIST extends ServerFailure {
  STUDENT_DOES_NOT_EXIST() : super("학생이 존재하지 않습니다.");
}

// ignore: camel_case_types
class ZOOM_MEETING_DOES_NOT_EXIST extends ServerFailure {
  ZOOM_MEETING_DOES_NOT_EXIST() : super("줌 미팅방이 존재하지 않습니다.");
}

// ignore: camel_case_types
class API_IS_DEPRECATED extends ServerFailure {
  API_IS_DEPRECATED() : super("이 API는 지원 중단될 예정입니다.");
}

// ignore: camel_case_types
class CURRENT_USER_NOT_SIGNED_IN extends ServerFailure {
  CURRENT_USER_NOT_SIGNED_IN() : super("현재 이 사용자는 가입되어 있지 않습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_VALID extends ServerFailure {
  CURRENT_USER_IS_NOT_VALID() : super("현재 이 사용자는 인증되어 있지 않습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_HAS_BEEN_SIGNED_IN extends ServerFailure {
  CURRENT_USER_HAS_BEEN_SIGNED_IN() : super("이미 로그인 된 사용자입니다.");
}

// ignore: camel_case_types
class LINK_SID_IS_UNKNOWN extends ServerFailure {
  LINK_SID_IS_UNKNOWN() : super("알수 없는 링크의 고유값입니다.");
}

// ignore: camel_case_types
class CURRENT_USER_LINK_MEMBER_IS_NOT_ALLOWED extends ServerFailure {
  CURRENT_USER_LINK_MEMBER_IS_NOT_ALLOWED()
      : super("이 사용자는 아직 링크에 가입 허가되지 않았습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_HAS_NOT_JOINED_THE_LINK extends ServerFailure {
  CURRENT_USER_HAS_NOT_JOINED_THE_LINK() : super("현재 사용자는 이 링크에 가입되지 않았습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_OWNER_OF_THE_LINK extends ServerFailure {
  CURRENT_USER_IS_NOT_OWNER_OF_THE_LINK() : super("현재 사용자는 이 링크의 개설자가 아닙니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_ADMINISTRABLE_OF_THE_LINK extends ServerFailure {
  CURRENT_USER_IS_NOT_ADMINISTRABLE_OF_THE_LINK()
      : super("현재 사용자는 이 링크에 운영 권한이 없습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_MANAGEABLE_OF_THE_LINK extends ServerFailure {
  CURRENT_USER_IS_NOT_MANAGEABLE_OF_THE_LINK()
      : super("현재 사용자는 이 링크에 매니징 권한이 없습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_ADMIN_OF_THE_LINK extends ServerFailure {
  CURRENT_USER_IS_NOT_ADMIN_OF_THE_LINK() : super("현재 사용자는 이 링크의 운영자가 아닙니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_MANAGER_OF_THE_LINK extends ServerFailure {
  CURRENT_USER_IS_NOT_MANAGER_OF_THE_LINK() : super("현재 사용자는 이 링크의 매니저가 아닙니다.");
}

// ignore: camel_case_types
class APP_NO_EXISTS extends ServerFailure {
  APP_NO_EXISTS() : super("앱이 존재하지 않습니다.");
}

// ignore: camel_case_types
class APP_SECRET_KEY_NO_EXISTS extends ServerFailure {
  APP_SECRET_KEY_NO_EXISTS() : super("앱의 암호키가 존재하지 않습니다.");
}

// ignore: camel_case_types
class APP_DOES_NOT_HAVE_PERMISSION extends ServerFailure {
  APP_DOES_NOT_HAVE_PERMISSION() : super("권한이 없습니다.");
}

// ignore: camel_case_types
class APP_DATA_IS_NOT_VALID extends ServerFailure {
  APP_DATA_IS_NOT_VALID() : super("유효하지 않는 데이터입니다.");
}

// ignore: camel_case_types
class APP_TOKEN_IS_EXPIRED extends ServerFailure {
  APP_TOKEN_IS_EXPIRED() : super("앱 토큰이 만료되었습니다.");
}

// ignore: camel_case_types
class APP_TOKEN_IS_NOT_VALID extends ServerFailure {
  APP_TOKEN_IS_NOT_VALID() : super("앱 토큰이 유효하지 않습니다.");
}

// ignore: camel_case_types
class APP_TOKEN_DOES_NOT_HAVE_PERMISSION extends ServerFailure {
  APP_TOKEN_DOES_NOT_HAVE_PERMISSION() : super("허가되지 않은 앱 토큰입니다.");
}

// ignore: camel_case_types
class SIGNATURE_DOES_NOT_EXIST extends ServerFailure {
  SIGNATURE_DOES_NOT_EXIST() : super("인증 토큰이 만료되었습니다.");
}

// ignore: camel_case_types
class REFRESH_TOKEN_DOES_NOT_EXIST extends ServerFailure {
  REFRESH_TOKEN_DOES_NOT_EXIST() : super("리프레쉬 토큰이 존재하지 않습니다.");
}

// ignore: camel_case_types
class SEND_AUTH_CODE_BY_SMS_FAILED extends ServerFailure {
  SEND_AUTH_CODE_BY_SMS_FAILED() : super("SMS로 인증코드 발송에 실패하였습니다.");
}

// ignore: camel_case_types
class SEND_AUTH_URL_BY_EMAIL_FAILED extends ServerFailure {
  SEND_AUTH_URL_BY_EMAIL_FAILED() : super("E-mail로 인증코드 발송에 실패하였습니다.");
}

// ignore: camel_case_types
class AUTH_CODE_IS_NOT_VALID extends ServerFailure {
  AUTH_CODE_IS_NOT_VALID() : super("인증코드가 유효하지 않습니다.");
}

// ignore: camel_case_types
class NEVER_REQUETED_SMS_AUTH_CODE extends ServerFailure {
  NEVER_REQUETED_SMS_AUTH_CODE() : super("SMS로 인증코드가 요청되지 않았습니다.");
}

// ignore: camel_case_types
class SMS_AUTH_CODE_DOES_NOT_MATCH extends ServerFailure {
  SMS_AUTH_CODE_DOES_NOT_MATCH() : super("SMS 인증코드가 일치하지 않습니다.");
}

// ignore: camel_case_types
class SMS_AUTH_CODE_HAS_BEEN_EXPIRED extends ServerFailure {
  SMS_AUTH_CODE_HAS_BEEN_EXPIRED() : super("SMS 인증코드가 만료되었습니다.");
}

// ignore: camel_case_types
class NEVER_REQUETED_EMAIL_AUTH_CODE extends ServerFailure {
  NEVER_REQUETED_EMAIL_AUTH_CODE() : super("이메일로 인증코드가 요청되지 않았습니다.");
}

// ignore: camel_case_types
class EMAIL_AUTH_CODE_DOES_NOT_MATCH extends ServerFailure {
  EMAIL_AUTH_CODE_DOES_NOT_MATCH() : super("이메일 인증코드가 일치하지 않습니다.");
}

// ignore: camel_case_types
class EMAIL_AUTH_CODE_HAS_BEEN_EXPIRED extends ServerFailure {
  EMAIL_AUTH_CODE_HAS_BEEN_EXPIRED() : super("이메일 인증코드가 만료되었습니다.");
}

// ignore: camel_case_types
class INPUT_NEW_PASSWORD_IS_SAME_WITH_CURRENT extends ServerFailure {
  INPUT_NEW_PASSWORD_IS_SAME_WITH_CURRENT()
      : super("새로운 비밀번호가 현재 비밀번호와 동일합니다.");
}

// ignore: camel_case_types
class INPUT_NEW_EMAIL_IS_SAME_WITH_CURRENT extends ServerFailure {
  INPUT_NEW_EMAIL_IS_SAME_WITH_CURRENT() : super("새로운 이메일이 현재의 이메일이 동일합니다.");
}

// ignore: camel_case_types
class INVALID_INPUT_MONGO_ID extends ServerFailure {
  INVALID_INPUT_MONGO_ID() : super("유효하지 않는 데이터입니다.");
}

// ignore: camel_case_types
class INVALID_INPUT_PAGINATION_PAGE extends ServerFailure {
  INVALID_INPUT_PAGINATION_PAGE() : super("유효하지 않는 데이터입니다.");
}

// ignore: camel_case_types
class INVALID_INPUT_PAGINATION_COUNT extends ServerFailure {
  INVALID_INPUT_PAGINATION_COUNT() : super("표시할 항목 수값이 유효하지 않는 데이터입니다.");
}

// ignore: camel_case_types
class INVALID_INPUT_EMAIL extends ServerFailure {
  INVALID_INPUT_EMAIL() : super("유효하지 않은 이메일입니다.");
}

// ignore: camel_case_types
class INVALID_INPUT_MOBILE_PHONE extends ServerFailure {
  INVALID_INPUT_MOBILE_PHONE() : super("유효하지 않은 폰번호입니다.");
}

// ignore: camel_case_types
class INVALID_INPUT_ACCOUNT_NAME extends ServerFailure {
  INVALID_INPUT_ACCOUNT_NAME() : super("유효하지 않은 계정명입니다.");
}

// ignore: camel_case_types
class INVALID_INPUT_DATE extends ServerFailure {
  INVALID_INPUT_DATE() : super("유효하지 않은 날짜입니다.");
}

// ignore: camel_case_types
class INVALID_INPUT_PASSWORD extends ServerFailure {
  INVALID_INPUT_PASSWORD() : super("유효하지 않은 비밀번호입니다.");
}

// ignore: camel_case_types
class INVALID_INPUT_USERNAME extends ServerFailure {
  INVALID_INPUT_USERNAME() : super("유효하지 않은 사용자명입니다.");
}

// ignore: camel_case_types
class INVALID_INPUT_LINK_SID extends ServerFailure {
  INVALID_INPUT_LINK_SID() : super("유효하지 않은 링크 고유값입니다.");
}

// ignore: camel_case_types
class ACCOUNT_PHONE_DOES_NOT_EXIST extends ServerFailure {
  ACCOUNT_PHONE_DOES_NOT_EXIST() : super("계정의 전화번호가 존재하지 않습니다.");
}

// ignore: camel_case_types
class ACCOUNT_EMAIL_HAS_ALREADY_BEEN_USED extends ServerFailure {
  ACCOUNT_EMAIL_HAS_ALREADY_BEEN_USED() : super("이미 사용 중인 이메일입니다.");
}

// ignore: camel_case_types
class ACCOUNT_PHONE_ALREADY_HAS_BEEN_USED extends ServerFailure {
  ACCOUNT_PHONE_ALREADY_HAS_BEEN_USED() : super("이미 사용 중인 전화번호입니다.");
}

// ignore: camel_case_types
class ACCOUNT_EMAIL_ALREADY_EXISTS extends ServerFailure {
  ACCOUNT_EMAIL_ALREADY_EXISTS() : super("이미 이메일 정보가 등록된 계정입니다.");
}

// ignore: camel_case_types
class ACCOUNT_ALREADY_SIGNED_UP extends ServerFailure {
  ACCOUNT_ALREADY_SIGNED_UP() : super("이미 로그인 된 계정입니다.");
}

// ignore: camel_case_types
class ACCOUNT_DOES_NOT_EXIST extends ServerFailure {
  ACCOUNT_DOES_NOT_EXIST() : super("존재하지 않는 계정입니다.");
}

// ignore: camel_case_types
class ACCOUNT_OF_PHONE_NO_EXISTS extends ServerFailure {
  ACCOUNT_OF_PHONE_NO_EXISTS() : super("계정의 전화번호가 존재하지 않습니다.");
}

// ignore: camel_case_types
class ACCOUNT_PASSWORD_DOES_NOT_MATCH extends ServerFailure {
  ACCOUNT_PASSWORD_DOES_NOT_MATCH() : super("계정의 비밀번호가 일치하지 않습니다.");
}

// ignore: camel_case_types
class ACCOUNT_DI_DOES_NOT_MATCH extends ServerFailure {
  ACCOUNT_DI_DOES_NOT_MATCH() : super("계정의 구분값이 일치하지 않습니다.");
}

// ignore: camel_case_types
class ACCOUNT_CREATION_LIMIT_EXCEEDED extends ServerFailure {
  ACCOUNT_CREATION_LIMIT_EXCEEDED()
      : super("계정 생성 개수를 초과하여 더 이상 계정을 생성할 수 없습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_ACCOUNT_DOES_NOT_EXIST extends ServerFailure {
  CURRENT_USER_ACCOUNT_DOES_NOT_EXIST() : super("본 유저의 계정이 존재하지 않습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_DEFAULT_PROFILE_DOES_NOT_EXIST extends ServerFailure {
  CURRENT_USER_DEFAULT_PROFILE_DOES_NOT_EXIST()
      : super("본 유저의 계정의 기본정보가 존재하지 않습니다.");
}

// ignore: camel_case_types
class PROFILE_DOES_NOT_EXIST extends ServerFailure {
  PROFILE_DOES_NOT_EXIST() : super("프로필 정보가 존재하지 않습니다.");
}

// ignore: camel_case_types
class CANNOT_DELETE_DEFAULT_PROFILE extends ServerFailure {
  CANNOT_DELETE_DEFAULT_PROFILE() : super("대표 프로필 정보는 삭제할 수 없습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_OWNS_LINK extends ServerFailure {
  CURRENT_USER_OWNS_LINK() : super("개설된 링크가 있어 회원 탈퇴를 할 수 없습니다.");
}

// ignore: camel_case_types
class LINK_DOES_NOT_EXIST extends ServerFailure {
  LINK_DOES_NOT_EXIST() : super("링크가 존재하지 않습니다.");
}

// ignore: camel_case_types
class LINK_SID_HAS_ALREADY_BEEN_USED extends ServerFailure {
  LINK_SID_HAS_ALREADY_BEEN_USED() : super("링크 고유값이 이미 존재합니다.");
}

// ignore: camel_case_types
class CURRENT_USER_LINK_MEMBER_DOES_NOT_EXIST extends ServerFailure {
  CURRENT_USER_LINK_MEMBER_DOES_NOT_EXIST()
      : super("본 유저는 링크 회원으로 등록된 정보가 없습니다.");
}

// ignore: camel_case_types
class LINK_GROUP_DOES_NOT_EXIST extends ServerFailure {
  LINK_GROUP_DOES_NOT_EXIST() : super("링크의 그룹이 존재하지 않습니다.");
}

// ignore: camel_case_types
class LINK_MEMBER_PHONE_ALREADY_EXISTS extends ServerFailure {
  LINK_MEMBER_PHONE_ALREADY_EXISTS() : super("이미 링크에 등록된 회원 전화번호입니다.");
}

// ignore: camel_case_types
class LINK_MEMBER_DOES_NOT_EXIST extends ServerFailure {
  LINK_MEMBER_DOES_NOT_EXIST() : super("링크 유저로 등록되어있지 않습니다.");
}

// ignore: camel_case_types
class LINK_HAS_CUSTOMERS extends ServerFailure {
  LINK_HAS_CUSTOMERS() : super("링크에 본인 외 회원이 있어 링크를 삭제할 수 없습니다.");
}

// ignore: camel_case_types
class CURRENT_LINK_MEMBER_DOES_NOT_EXIST extends ServerFailure {
  CURRENT_LINK_MEMBER_DOES_NOT_EXIST() : super("본 링크의 링크회원이 아닙니다.");
}

// ignore: camel_case_types
class CURRENT_USER_LINK_MEMBER_ALREADY_EXISTS extends ServerFailure {
  CURRENT_USER_LINK_MEMBER_ALREADY_EXISTS() : super("본 링크에 이미 등록되어 있는 회원입니다.");
}

// ignore: camel_case_types
class CANNOT_CHANGE_LINK_MEMBER_ROLE_TO_OWNER extends ServerFailure {
  CANNOT_CHANGE_LINK_MEMBER_ROLE_TO_OWNER()
      : super("본 회원에게 링크 개설자 권한을 줄 수 없습니다.");
}

// ignore: camel_case_types
class CANNOT_CHANGE_LINK_MEMBER_ROLE_TO_OWNER_OR_ADMIN extends ServerFailure {
  CANNOT_CHANGE_LINK_MEMBER_ROLE_TO_OWNER_OR_ADMIN()
      : super("본 회원에게 링크 운영자 권한을 줄수 없습니다.");
}

// ignore: camel_case_types
class CANNOT_CHANGE_LINK_MEMBER_WHO_IS_OWNER extends ServerFailure {
  CANNOT_CHANGE_LINK_MEMBER_WHO_IS_OWNER() : super("본 회원을 링크 개설자로 변경할 수 없습니다.");
}

// ignore: camel_case_types
class CANNOT_CHANGE_LINK_MEMBER_WHO_IS_OWNER_OR_ADMIN extends ServerFailure {
  CANNOT_CHANGE_LINK_MEMBER_WHO_IS_OWNER_OR_ADMIN()
      : super("본 회원을 링크 운영자로 변경할 수 없습니다.");
}

// ignore: camel_case_types
class CANNOT_CREATE_LINK_NOTIFICATION extends ServerFailure {
  CANNOT_CREATE_LINK_NOTIFICATION() : super("본 링크를 개설할 수 없습니다.");
}

// ignore: camel_case_types
class LINK_NOTIFICATION_DOES_NOT_EXIST extends ServerFailure {
  LINK_NOTIFICATION_DOES_NOT_EXIST() : super("해당 링크를 찾을 수 없습니다.");
}

// ignore: camel_case_types
class PRODUCT_DOES_NOT_EXIST extends ServerFailure {
  PRODUCT_DOES_NOT_EXIST() : super("상품이 존재하지 않습니다.");
}

// ignore: camel_case_types
class PRODUCT_CATEGORY_DOES_NOT_EXIST extends ServerFailure {
  PRODUCT_CATEGORY_DOES_NOT_EXIST() : super("상품 카테고리가 존재하지 않습니다.");
}

// ignore: camel_case_types
class SOME_PRODUCTS_DO_NOT_EXIST extends ServerFailure {
  SOME_PRODUCTS_DO_NOT_EXIST() : super("일부 상품이 존재하지 않습니다.");
}

// ignore: camel_case_types
class ADMIN_ROLE_MUST_BE_SYSTEM_OR_SERVICE extends ServerFailure {
  ADMIN_ROLE_MUST_BE_SYSTEM_OR_SERVICE() : super("시스템 또는 서비스 권한이 필요합니다.");
}

// ignore: camel_case_types
class ADMIN_LOGIN_ID_HAS_ALREADY_BEEN_USED extends ServerFailure {
  ADMIN_LOGIN_ID_HAS_ALREADY_BEEN_USED() : super("이미 로그인 된 관리자 입니다.");
}

// ignore: camel_case_types
class ADMIN_DOES_NOT_EXIST extends ServerFailure {
  ADMIN_DOES_NOT_EXIST() : super("해당 관리자를 찾을 수 없습니다.");
}

// ignore: camel_case_types
class ADMIN_PASSWORD_DOES_NOT_MATCH extends ServerFailure {
  ADMIN_PASSWORD_DOES_NOT_MATCH() : super("관리자 비밀번호가 맞지 않습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_SUPER_ADMIN extends ServerFailure {
  CURRENT_USER_IS_NOT_SUPER_ADMIN() : super("본 계정은 슈퍼관리자가 아닙니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_SYSTEM_ADMIN extends ServerFailure {
  CURRENT_USER_IS_NOT_SYSTEM_ADMIN() : super("본 계정은 시스템 관리자가 아닙니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_SERVICE_ADMIN extends ServerFailure {
  CURRENT_USER_IS_NOT_SERVICE_ADMIN() : super("본 계정은 서비스 관리자가 아닙니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_SYSTEM_ADMINISTRABLE extends ServerFailure {
  CURRENT_USER_IS_NOT_SYSTEM_ADMINISTRABLE() : super("본 계정은 시스템 관리자 권한이 없습니다.");
}

// ignore: camel_case_types
class CURRENT_USER_IS_NOT_SERVICE_ADMINISTRABLE extends ServerFailure {
  CURRENT_USER_IS_NOT_SERVICE_ADMINISTRABLE()
      : super("본 계정은 서비스 관리자 권한이 없습니다.");
}

// ignore: camel_case_types
class NOTICE_DOES_NOT_EXIST extends ServerFailure {
  NOTICE_DOES_NOT_EXIST() : super("해당 공지사항을 찾을 수 없습니다.");
}

// ignore: camel_case_types
class FAQ_DOES_NOT_EXIST extends ServerFailure {
  FAQ_DOES_NOT_EXIST() : super("해당 FAQ를 찾을 수 없습니다.");
}

// ignore: camel_case_types
class HELP_DOES_NOT_EXIST extends ServerFailure {
  HELP_DOES_NOT_EXIST() : super("해당 도움말을 찾을 수 없습니다.");
}

// ignore: camel_case_types
class INQUIRY_DOES_NOT_EXIST extends ServerFailure {
  INQUIRY_DOES_NOT_EXIST() : super("해당 문의를 찾을 수 없습니다.");
}

// ignore: camel_case_types
class SERVICE_CODE_DOES_NOT_EXIST extends ServerFailure {
  SERVICE_CODE_DOES_NOT_EXIST() : super("서비스 코드를 찾을 수 없습니다.");
}

// ignore: camel_case_types
class BLOCK_WORD_DOES_NOT_EXIST extends ServerFailure {
  BLOCK_WORD_DOES_NOT_EXIST() : super("해당 금칙어를 찾을 수 없습니다.");
}

// ignore: camel_case_types
class PROPERTY_DOES_NOT_EXIST extends ServerFailure {
  PROPERTY_DOES_NOT_EXIST() : super("해당 환경 변수를 찾을 수 없습니다.");
}

// ignore: camel_case_types
class TERMS_DOES_NOT_EXIST extends ServerFailure {
  TERMS_DOES_NOT_EXIST() : super("해당 약관을 찾을 수 없습니다.");
}

// ignore: camel_case_types
class ORDER_STOCK_IS_NOT_REMITTED extends ServerFailure {
  ORDER_STOCK_IS_NOT_REMITTED() : super("주문의 재고가 송금 완료 상태가 아닙니다.");
}

// ignore: camel_case_types
class ORDER_STOCK_HAS_PROVIDED_ALREADY extends ServerFailure {
  ORDER_STOCK_HAS_PROVIDED_ALREADY() : super("이미 등록된 수강생입니다.");
}

class SMS_AUTH_CODE_DOES_NOT_EXIST extends ServerFailure {
  SMS_AUTH_CODE_DOES_NOT_EXIST() : super("SMS 인증코드가 일치하지 않습니다.");
}

class PRODUCT_IS_NOT_DRAWABLE extends ServerFailure {
  PRODUCT_IS_NOT_DRAWABLE() : super("수업 신청을 할 수 없는 수업입니다.");
}

class PRODUCT_IS_NOT_APPLICABLE_PERIOD extends ServerFailure {
  PRODUCT_IS_NOT_APPLICABLE_PERIOD() : super("수업 신청 기간이 아닙니다");
}

class INPUT_LINK_SID_IS_NOT_VALID extends ServerFailure {
  INPUT_LINK_SID_IS_NOT_VALID() : super("존재 하지 않은 링크입니다.");
}

class PRODUCT_APPLICATION_ALREADY_EXISTS extends ServerFailure {
  PRODUCT_APPLICATION_ALREADY_EXISTS() : super("이미 수강신청 되었습니다.");
}

class CHAT_ROOM_ALREADY_EXISTS extends ServerFailure {
  CHAT_ROOM_ALREADY_EXISTS() : super("이미 존재하는 채팅방입니다.");
}

class PRODUCT_APPLICATION_COUNT_IS_MAXIMUM_NUMBER extends ServerFailure {
  PRODUCT_APPLICATION_COUNT_IS_MAXIMUM_NUMBER()
      : super("신청 인원이 초과되어 신청할 수 없습니다.");
}

class INPUT_PHONE_WAS_USED_BY_DROPPED_ACCOUNT extends ServerFailure {
  INPUT_PHONE_WAS_USED_BY_DROPPED_ACCOUNT() : super("탈퇴한 계정의 휴대폰번호입니다.");
}

class APPLICATION_START_DATE_CAN_NOT_BE_EARLIER_THAN_CURRENT_DATE
    extends ServerFailure {
  APPLICATION_START_DATE_CAN_NOT_BE_EARLIER_THAN_CURRENT_DATE()
      : super("신청기간이 현재시간보다 이전 시간일수 없습니다.");
}

class PRODUCT_STATUS_IS_NOT_SALE extends ServerFailure {
  PRODUCT_STATUS_IS_NOT_SALE()
      : super("해당 수업은 현재 신청하실 수  없습니다.\n개설자에게 문의해주세요.");
}

class PRODUCT_APPLICATION_GRADE_IS_NOT_ALLOWED extends ServerFailure {
  PRODUCT_APPLICATION_GRADE_IS_NOT_ALLOWED() : super("신청할 수 있는 학년이 아닙니다.");
}
