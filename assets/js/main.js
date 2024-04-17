const colorPalettePermission = 0;
const createElementPermission = 1;
const editElementPermission = 2;
const createUserPermission = 3;
const editUserPermission = 4;

var lastScrollPosition, currentScrollPosition;
var scrollingDown;

var lastTouchPositionX, lastTouchPositionY;
var verifyTouch;

var waitingToScrollX;

var animatingWhatsappButton = false;

var loadings = 0;

function addLoading() {
    loadings += 1;
    if (loadings > 0) {
        window.document.getElementById("loading-screen").style.display = "";
        window.document.body.style.overflow = "hidden";
    }
}

function subLoading() {
    loadings -= 1;
    if (loadings < 0) {
        loadings = 0;
    }
    if (loadings == 0) {
        window.document.getElementById("loading-screen").style.display = "";
        window.document.body.style.overflow = "hidden";
        adjustMainRetractableMenu();
        setRetractorsListeners();
        adjustRetractableMenus();
        setCarousels();
        adjustCarousels();
        setMainFooter();
        adjustWhatsappButton();
        setTextareas();
        setTextsWordBreak();
        window.document.getElementById("loading-screen").style.display = "none";
        window.document.body.style.overflow = "";
    }
}

addLoading();

window.addEventListener("load", function () {
    $("body").on("mousedown", function (event) {
        if ($(event.target).attr("id") != "floating-action-button") {
            $("#floating-action-button").remove();
        }
    });
    window.addEventListener("resize", function () {
        adjustMainRetractableMenu();
        setRetractorsListeners();
        adjustRetractableMenus();
        adjustCarousels();
        setMainFooter();
        adjustWhatsappButton();
        setTextareas();
        setTextsWordBreak();
    });
    window.addEventListener("scroll", function () {
        if (lastScrollPosition != null && currentScrollPosition != null && window.document.getElementById("main-menu")) {
            var mainMenu = window.document.getElementById("main-menu");
            var mainMenuHeight = mainMenu.getBoundingClientRect().height;
            if (window.getComputedStyle(window.document.getElementById("retracted-main-menu-lmd")).display != "none") {
                window.document.getElementById("retracted-main-menu-lmd").style.display = "none";
                var mainMenuHeight = mainMenu.getBoundingClientRect().height;
                window.document.getElementById("retracted-main-menu-lmd").style.display = "";
            }
            currentScrollPosition = window.scrollY;
            if (currentScrollPosition > lastScrollPosition && currentScrollPosition > mainMenuHeight) {
                if ((scrollingDown == false || scrollingDown == null) && window.getComputedStyle(mainMenu).top == "0px") {
                    var retractedLsmStyle = window.getComputedStyle(window.document.getElementById("retracted-main-menu-lsm"));
                    var retractedLmdStyle = window.getComputedStyle(window.document.getElementById("retracted-main-menu-lmd"));
                    if (retractedLsmStyle.display != "none" && retractedLsmStyle.right == "0px" || retractedLmdStyle.display != "none" && retractedLmdStyle.height != "0px") {
                        mainMenu.getElementsByClassName("retractable-menu-retractor")[0].click();
                    }
                    mainMenu.style.top = "-" + mainMenu.getBoundingClientRect().height + "px";
                    mainMenu.animate([
                        {top:  "0px"},
                        {top: "-" + mainMenu.getBoundingClientRect().height + "px"}
                    ], 100, 1);
                }
                scrollingDown = true;
            } else {
                if ((scrollingDown == true || scrollingDown == null) && window.getComputedStyle(mainMenu).top != "0px") {
                    mainMenu.style.top = "0px";
                    mainMenu.animate([
                        {top: "-" + mainMenu.getBoundingClientRect().height + "px"},
                        {top:  "0px"}
                    ], 100, 1);
                }
                scrollingDown = false;
            }
            lastScrollPosition = currentScrollPosition;
        }
        adjustWhatsappButton();
    });
    lastScrollPosition = currentScrollPosition = window.scrollY;
    subLoading();
});

function setRetractorsListeners() {
    var retractors = window.document.getElementsByClassName("retractable-menu-retractor");
    for (var i = 0; i < retractors.length; i++) {
        var retractor = retractors[i];
        var retracted = window.document.getElementById(retractor.getAttribute("data-toggle"));
        retractor.style.cursor = "pointer";
        retracted.style.display = "none";
        if (retractor.getAttribute("data-alternate") == "true") {
            retractor.children[0].style.display = "";
            retractor.children[1].style.display = "none";
        }
        retractor.onclick = function (event) {
            var retracted = window.document.getElementById(this.getAttribute("data-toggle"))
            if (window.getComputedStyle(retracted).display == "none") {
                retracted.style.display = "";
                if (retracted.id == "retracted-main-menu-lsm" || retracted.id == "retracted-main-menu-lmd") {
                    var mainMenu = window.document.getElementById("main-menu");
                    if ((scrollingDown == true || scrollingDown == null) && window.getComputedStyle(mainMenu).top != "0px") {
                        mainMenu.style.top = "0px";
                        mainMenu.animate([
                            {top: "-" + mainMenu.getBoundingClientRect().height + "px"},
                            {top:  "0px"}
                        ], 100, 1);
                    }
                    scrollingDown = false;
                }
                if (retracted.id == "retracted-main-menu-lsm") {
                    retracted.animate([
                        {right: "-" + retracted.clientWidth + "px"},
                        {right:  "0px"}
                    ], 100, 1);
                } else if (retracted.id == "retracted-main-menu-lmd") {
                    retracted.animate([
                        {height: "0px"},
                        {height:  retracted.clientHeight + "px"}
                    ], 100, 1);
                }
                if (this.getAttribute("data-alternate") == "true") {
                    this.children[0].style.display = "none";
                    this.children[1].style.display = "";
                }
            } else {
                if (retracted.id == "retracted-main-menu-lsm") {
                    retracted.animate([
                        {right:  "0px"},
                        {right: "-" + retracted.clientWidth + "px"}
                    ], 100, 1);
                    window.setTimeout(function () {
                        retracted.style.display = "none";
                    }, 100);
                } else if (retracted.id == "retracted-main-menu-lmd") {
                    retracted.animate([
                        {height: retracted.clientHeight + "px"},
                        {height:  "0px"}
                    ], 100, 1);
                    window.setTimeout(function () {
                        retracted.style.display = "none";
                    }, 100);
                } else {
                    retracted.style.display = "none";
                }
                if (this.getAttribute("data-alternate") == "true") {
                    this.children[0].style.display = "";
                    this.children[1].style.display = "none";
                }
            }
            event.stopPropagation ? event.stopPropagation() : event.cancelBubble = true;
        };
    }
    window.document.body.ontouchend = function () {
        window.document.body.click();
    }
    window.document.body.onclick = function () {
        for (var i = 0; i < retractors.length; i++) {
            var retractor = retractors[i];
            var retracted = window.document.getElementById(retractor.getAttribute("data-toggle"));
            if (window.getComputedStyle(retracted).display != "none") {
                if (retracted.id == "retracted-main-menu-lsm") {
                    retracted.animate([
                        {right:  "0px"},
                        {right: "-" + retracted.clientWidth + "px"}
                    ], 100, 1);
                    window.setTimeout(function () {
                        retracted.style.display = "none";
                    }, 100);
                } else if (retracted.id == "retracted-main-menu-lmd") {
                    retracted.animate([
                        {height: retracted.clientHeight + "px"},
                        {height:  "0px"}
                    ], 100, 1);
                    window.setTimeout(function () {
                        retracted.style.display = "none";
                    }, 100);
                } else {
                    retracted.style.display = "none";
                }
                if (retractor.getAttribute("data-alternate") == "true") {
                    retractor.children[0].style.display = "";
                    retractor.children[1].style.display = "none";
                }
            }
        }
    };
}

function adjustRetractableMenus() {
    var retractableMenus = window.document.getElementsByClassName("retractable-menu");
    for (var i = 0; i < retractableMenus.length; i++) {
        var retractableMenu = retractableMenus[i];
        var retractableMenuOptions = retractableMenu.getElementsByClassName("retractable-menu-option");
        var retractableMenuRetractor = retractableMenu.getElementsByClassName("retractable-menu-retractor")[0];

        retractableMenuRetractor.style.display = "none";
        for (var j = 0; j < retractableMenuOptions.length; j++) {
            retractableMenuOptions[j].style.display = "";
        }

        var maxWidth = retractableMenu.offsetWidth;
        var currentWidth = 0;
        for (var j = 0; j < retractableMenuOptions.length; j++) {
            currentWidth += retractableMenuOptions[j].offsetWidth;
        }

        if (currentWidth > maxWidth) {
            retractableMenuRetractor.style.display = "";
            for (var j = 0; j < retractableMenuOptions.length; j++) {
                retractableMenuOptions[j].style.display = "none";
            }
        } else {
            var retracted = window.document.getElementById(retractableMenuRetractor.getAttribute("data-toggle"));
            if (window.getComputedStyle(retracted).display != "none") {
                if (retracted.id == "retracted-main-menu-lsm") {
                    retracted.animate([
                        {right:  "0px"},
                        {right: "-" + retracted.clientWidth + "px"}
                    ], 100, 1);
                    window.setTimeout(function () {
                        retracted.style.display = "none";
                    }, 100);
                } else if (retracted.id == "retracted-main-menu-lmd") {
                    retracted.animate([
                        {height: retracted.clientHeight + "px"},
                        {height:  "0px"}
                    ], 100, 1);
                    window.setTimeout(function () {
                        retracted.style.display = "none";
                    }, 100);
                } else {
                    retracted.style.display = "none";
                }
                if (retractableMenuRetractor.getAttribute("data-alternate") == "true") {
                    retractableMenuRetractor.children[0].style.display = "";
                    retractableMenuRetractor.children[1].style.display = "none";
                }
            }
        }
    }
}

function setCarousels() {
    var carousels = window.document.getElementsByClassName("carousel");
    for (var i = 0; i < carousels.length; i++) {
        var carousel = carousels[i];
        var display = carousel.getElementsByClassName("carousel-display")[0];
        var items = display.getElementsByClassName("carousel-item");
        var currentItem = parseInt(display.getAttribute("data-focused-item"));
        display.style.overflow = "hidden";
        display.style.cursor = "grab";
        display.onscroll = function () {
            if (this.scrollLeft == 0) {
                this.parentElement.getElementsByClassName("carousel-previous-button")[0].style.boxShadow = "none";
            } else {
                this.parentElement.getElementsByClassName("carousel-previous-button")[0].style.boxShadow = "";
            }
            if (this.scrollLeft >= Math.floor(this.children[0].getBoundingClientRect().width - this.getBoundingClientRect().width)) {
                this.parentElement.getElementsByClassName("carousel-next-button")[0].style.boxShadow = "none";
            } else {
                this.parentElement.getElementsByClassName("carousel-next-button")[0].style.boxShadow = "";
            }
        };
        display.onmousedown = function () {
            this.style.cursor = "grabbing";
            this.style.userSelect = "none";
            this.onmousemove = function (event) {
                this.style.scrollBehavior = "auto";
                this.scroll(this.scrollLeft - event.movementX, 0);
                this.style.scrollBehavior = "";
                waitingToScrollX = event.movementX;
            };
        };
        display.ontouchstart = function (event) {
            window.document.body.style.overflow = "hidden";
            this.style.userSelect = "none";
            lastTouchPositionX = event.touches[0].pageX;
            lastTouchPositionY = event.touches[0].pageY;
            verifyTouch = true;
            this.ontouchmove = function (event) {
                if (Math.abs(event.touches[0].pageY - lastTouchPositionY) > Math.abs(event.touches[0].pageX - lastTouchPositionX) && verifyTouch) {
                    display.style.userSelect = "";
                    window.document.body.style.overflow = "";
                    display.ontouchmove = null;
                } else {
                    this.style.scrollBehavior = "auto";
                    this.scroll(this.scrollLeft - (event.touches[0].pageX - lastTouchPositionX), 0);
                    this.style.scrollBehavior = "";
                    waitingToScrollX = event.touches[0].pageX - lastTouchPositionX;
                }
                lastTouchPositionX = event.touches[0].pageX;
                lastTouchPositionY = event.touches[0].pageY;
                verifyTouch = false;
            };
            this.ontouchend = function () {
                this.scroll(this.scrollLeft - waitingToScrollX * 10, 0);
                waitingToScrollX = 0;
            };
        };
        carousel.getElementsByClassName("carousel-previous-button")[0].addEventListener("click", function () {
            var display = this.parentElement.getElementsByClassName("carousel-display")[0];
            var items = display.getElementsByClassName("carousel-item");
            var currentItem = parseInt(display.getAttribute("data-focused-item"));
            if (currentItem > 0) {
                currentItem -= 1;
            }
            display.scroll(items[currentItem].offsetLeft - items[0].offsetLeft - display.getBoundingClientRect().width / 2 + items[currentItem].getBoundingClientRect().width / 2, 0);
            display.setAttribute("data-focused-item", currentItem);
        });
        carousel.getElementsByClassName("carousel-next-button")[0].addEventListener("click", function () {
            var display = this.parentElement.getElementsByClassName("carousel-display")[0];
            var items = display.getElementsByClassName("carousel-item");
            var currentItem = parseInt(display.getAttribute("data-focused-item"));
            if (currentItem < items.length - 1) {
                currentItem += 1;
            }
            display.scroll(items[currentItem].offsetLeft - items[0].offsetLeft - display.getBoundingClientRect().width / 2 + items[currentItem].getBoundingClientRect().width / 2, 0);
            display.setAttribute("data-focused-item", currentItem);
        });
    }
    window.document.addEventListener("mouseup", function () {
        var carousels = window.document.getElementsByClassName("carousel");
        for (var i = 0; i < carousels.length; i++) {
            var carousel = carousels[i];
            var display = carousel.getElementsByClassName("carousel-display")[0];
            display.style.cursor = "grab";
            display.style.userSelect = "";
            display.onmousemove = null;
            display.scroll(display.scrollLeft - waitingToScrollX * 10, 0);
            waitingToScrollX = 0;
        }
    });
    window.document.addEventListener("touchend", function () {
        var carousels = window.document.getElementsByClassName("carousel");
        for (var i = 0; i < carousels.length; i++) {
            var carousel = carousels[i];
            var display = carousel.getElementsByClassName("carousel-display")[0];
            display.style.userSelect = "";
            window.document.body.style.overflow = "";
            display.ontouchmove = null;
            display.ontouchend = null;
        }
    });
}

function adjustCarousels() {
    var carousels = window.document.getElementsByClassName("carousel");
    for (var i = 0; i < carousels.length; i++) {
        var display = carousels[i].getElementsByClassName("carousel-display")[0];
        var items = display.getElementsByClassName("carousel-item");
        for (var j = 0; j < items.length; j++) {
            items[j].style.maxWidth = (display.getBoundingClientRect().width - 40) + "px";
        }
        if (display.scrollLeft == 0) {
            display.parentElement.getElementsByClassName("carousel-previous-button")[0].style.boxShadow = "none";
        } else {
            display.parentElement.getElementsByClassName("carousel-previous-button")[0].style.boxShadow = "";
        }
        if (display.scrollLeft >= Math.floor(display.children[0].getBoundingClientRect().width - display.getBoundingClientRect().width)) {
            display.parentElement.getElementsByClassName("carousel-next-button")[0].style.boxShadow = "none";
        } else {
            display.parentElement.getElementsByClassName("carousel-next-button")[0].style.boxShadow = "";
        }
    }
}



function adjustMainRetractableMenu() {
    if (window.document.getElementById("main-menu")) {
        var mainMenuRetractors = window.document.getElementById("main-menu").getElementsByClassName("retractable-menu-retractor");
        var mainMenuToggle = mainMenuRetractors[0].getAttribute("data-toggle");
        if (window.innerWidth >= 700) {
            mainMenuToggle = mainMenuToggle.substring(0, mainMenuToggle.length - 3) + "lmd";
        } else {
            mainMenuToggle = mainMenuToggle.substring(0, mainMenuToggle.length - 3) + "lsm";
        }
        for (var i = 0; i < mainMenuRetractors.length; i++) {
            mainMenuRetractors[i].setAttribute("data-toggle", mainMenuToggle);
        }
    }
}

function setMainFooter() {
    if (window.document.getElementById("main-footer")) {
        var mainFooter = window.document.getElementById("main-footer");
        var mainFooterCredits = window.document.getElementById("main-footer-credits");
        mainFooter.style.height = window.getComputedStyle(mainFooterCredits).height;
    }
}

function adjustWhatsappButton() {
    if (!animatingWhatsappButton && window.document.getElementById("main-footer")) {
        var mainFooter = window.document.getElementById("main-footer");
        var whatsappButton = window.document.getElementById("whatsapp-button");
        if (window.innerHeight > mainFooter.getBoundingClientRect().top) {
            if (whatsappButton.style.display != "none") {
                whatsappButton.animate([
                    {scale:  "100%"},
                    {scale: "0"}
                ], 100, 1);
                window.setTimeout(function () {
                    whatsappButton.style.display = "none";
                    animatingWhatsappButton = false;
                    adjustWhatsappButton();
                }, 100);
                animatingWhatsappButton = true;
            }
        } else {
            if (whatsappButton.style.display == "none") {
                whatsappButton.style.display = "";
                whatsappButton.animate([
                    {scale:  "0"},
                    {scale: "100%"}
                ], 100, 1);
                window.setTimeout(function () {
                    animatingWhatsappButton = false;
                    adjustWhatsappButton();
                }, 100);
                animatingWhatsappButton = true;
            }
        }
    }
}

function setTextareas() {
    $("textarea").each(function () {
        var lineHeight = parseInt($(this).css('lineHeight'));
        $(this).attr("rows", "1");
        $(this).attr("rows", $(this)[0].scrollHeight / lineHeight);
    });
    $("textarea").on("input", function () {
        var lineHeight = parseInt($(this).css('lineHeight'));
        $(this).attr("rows", "1");
        $(this).attr("rows", $(this)[0].scrollHeight / lineHeight);
    });
}

function setTextsWordBreak() {
    $("*").each(function () {
        $(this).css("word-break", "normal");
        if ($(this)[0].scrollWidth > $(this)[0].clientWidth) {
            $(this).css("word-break", "break-all");
        }
    });
}

/* Error popup in login.php */

function ErrorEmailRequired (e) {
    e.preventDefault();
    const email = document.getElementById("email").value;
    if (email == "") {
        document.getElementById('email-required').style.display="block";
    }
    else{
        document.getElementById('email-required').style.display="none";
    }

    if (EmailValid(email) || email=="") {
        document.getElementById('email-error').style.display="none";
    }
    else{
        document.getElementById('email-error').style.display="block";
    }
}

function EmailValid(email) { 
    return /^[A-Za-z0-9_\.]{1,}@[A-Za-z0-9_\.]{1,}\.[A-Za-z0-9_\.]{1,}$/.test(email)
}

buttonConfirm = document.getElementById("email");
buttonConfirm?.addEventListener("change", ErrorEmailRequired);

function getUserToken() {
    let cookies = decodeURIComponent(window.document.cookie).split(";");
    for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i];
        while (cookie[0] == " ") {
            cookie = cookie.substring(1);
        }
        if (cookie.indexOf("token=") == 0) {
            return cookie.substring(6);
        }
    }
    return "";
}

function parseCssVariable(variable) {
    result = variable.slice(2);
    result = result.replaceAll("-", " ");
    result = result[0].toUpperCase() + result.slice(1);
    return result;
}

$.ajaxSetup({
    headers: {"Token": getUserToken()}
});