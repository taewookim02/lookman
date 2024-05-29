document.addEventListener("DOMContentLoaded", () => {
  const inputRadios = document.querySelectorAll("input[name='address']");
  const memberNameEl = document.querySelector(".memberName");
  const phoneNumberEl = document.querySelector(".phoneNumber");
  const postcodeEl = document.querySelector(".postcode");
  const addressEl = document.querySelector(".address");
  const extraAddressEl = document.querySelector(".extraAddress");
  const detailedAddressEl = document.querySelector(".detailedAddress");
  const shippingReqEl = document.querySelector(".shippingReq");

  const payment = (
    memberEmail,
    memberName,
    memberPhone,
    makeMerchantUid,
    totalPrice,
    concatProdName,
    selectedPaymentMethod
  ) => {
    if (confirm("구매 하시겠습니까?")) {
      IMP.init("imp13251138");
      IMP.request_pay(
        {
          pg: selectedPaymentMethod,
          pay_method: "card",
          merchant_uid: "IMP" + makeMerchantUid,
          name: concatProdName,
          amount: totalPrice,
          buyer_email: memberEmail,
          buyer_name: memberName,
          buyer_tel: memberPhone,
        },
        async function (res) {
          if (res.success) {
            console.log(res);
            console.log("hello world!");
            // make api call to backend to save data
          } else if (res.success == false) {
            alert(res.error_msg);
          }
        }
      );
    } else {
      console.log("falsefalse");
      return false;
    }
  };
  const payBtn = document.querySelector("#pay-btn");
  payBtn.addEventListener("click", () => {
    // 구매자 정보
    const totalPrice = payBtn.dataset.totalPrice;
    const memberNo = payBtn.dataset.memberNo;
    const memberName = payBtn.dataset.memberName;
    const memberEmail = payBtn.dataset.memberId;
    const memberPhone = payBtn.dataset.memberPhone;

    const today = new Date();
    const hours = today.getHours();
    const minutes = today.getMinutes();
    const seconds = today.getSeconds();
    const milliseconds = today.getMilliseconds();
    const makeMerchantUid =
      `${hours}` + `${minutes}` + `${seconds}` + `${milliseconds}`;

    // 상품명
    const productNames = document.querySelectorAll(".product-name");
    const productArray = Array.from(productNames).map((el) => el.textContent);
    let concatProdName = "";
    if (productArray.length === 1) {
      concatProdName = productArray[0];
    } else if (productArray.length > 1) {
      concatProdName = `${productArray[0]} 외 ${productArray.length - 1}건`;
    }

    // imp
    let IMP = window.IMP;

    // determine which pg
    const selectedPaymentMethod = document.querySelector(
      'input[name="payment-method"]:checked'
    ).id;
    console.log(selectedPaymentMethod);

    payment(
      memberEmail,
      memberName,
      memberPhone,
      makeMerchantUid,
      totalPrice,
      concatProdName,
      selectedPaymentMethod
    );
  });

  inputRadios.forEach((radio) => {
    radio.addEventListener("click", () => {
      const addressNo = radio.dataset.addressNo;

      $.ajax({
        url: "/app/address/rest",
        method: "GET",
        data: { addressNo },
        success: function (res) {
          memberNameEl.textContent = res.memberName;
          phoneNumberEl.textContent = res.phoneNo;
          postcodeEl.textContent = `(${res.postcode})`;
          addressEl.textContent = res.address;
          extraAddressEl.textContent = res.extraAddress;
          detailedAddressEl.textContent = res.detailedAddress;
          shippingReqEl.textContent = res.defaultReq;
        },
        error: function (data) {
          alert(data);
        },
      });
    });
  });
});
