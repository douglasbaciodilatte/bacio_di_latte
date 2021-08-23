(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["main"],{

/***/ "./src/$$_lazy_route_resource lazy recursive":
/*!**********************************************************!*\
  !*** ./src/$$_lazy_route_resource lazy namespace object ***!
  \**********************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

function webpackEmptyAsyncContext(req) {
	// Here Promise.resolve().then() is used instead of new Promise() to prevent
	// uncaught exception popping up in devtools
	return Promise.resolve().then(function() {
		var e = new Error("Cannot find module '" + req + "'");
		e.code = 'MODULE_NOT_FOUND';
		throw e;
	});
}
webpackEmptyAsyncContext.keys = function() { return []; };
webpackEmptyAsyncContext.resolve = webpackEmptyAsyncContext;
module.exports = webpackEmptyAsyncContext;
webpackEmptyAsyncContext.id = "./src/$$_lazy_route_resource lazy recursive";

/***/ }),

/***/ "./src/app/app.component.css":
/*!***********************************!*\
  !*** ./src/app/app.component.css ***!
  \***********************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "@media (max-width: 767px) {\n  /* On small screens, the nav menu spans the full width of the screen. Leave a space for it. */\n  .body-content {\n    padding-top: 50px;\n  }\n}\n\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInNyYy9hcHAvYXBwLmNvbXBvbmVudC5jc3MiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7RUFDRSw4RkFBOEY7RUFDOUY7SUFDRSxrQkFBa0I7R0FDbkI7Q0FDRiIsImZpbGUiOiJzcmMvYXBwL2FwcC5jb21wb25lbnQuY3NzIiwic291cmNlc0NvbnRlbnQiOlsiQG1lZGlhIChtYXgtd2lkdGg6IDc2N3B4KSB7XG4gIC8qIE9uIHNtYWxsIHNjcmVlbnMsIHRoZSBuYXYgbWVudSBzcGFucyB0aGUgZnVsbCB3aWR0aCBvZiB0aGUgc2NyZWVuLiBMZWF2ZSBhIHNwYWNlIGZvciBpdC4gKi9cbiAgLmJvZHktY29udGVudCB7XG4gICAgcGFkZGluZy10b3A6IDUwcHg7XG4gIH1cbn1cbiJdfQ== */"

/***/ }),

/***/ "./src/app/app.component.html":
/*!************************************!*\
  !*** ./src/app/app.component.html ***!
  \************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "<div class='container-fluid'>\n  <div class='row'>\n    <!--<div class='col-sm-3'>\n      <app-nav-menu></app-nav-menu>\n    </div>-->\n    <div class='container-fluid'>\n      <router-outlet></router-outlet>\n    </div>\n  </div>\n</div>\n"

/***/ }),

/***/ "./src/app/app.component.ts":
/*!**********************************!*\
  !*** ./src/app/app.component.ts ***!
  \**********************************/
/*! exports provided: AppComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "AppComponent", function() { return AppComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};

var AppComponent = /** @class */ (function () {
    function AppComponent() {
        this.title = 'app';
    }
    AppComponent = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"])({
            selector: 'app-root',
            template: __webpack_require__(/*! ./app.component.html */ "./src/app/app.component.html"),
            styles: [__webpack_require__(/*! ./app.component.css */ "./src/app/app.component.css")]
        })
    ], AppComponent);
    return AppComponent;
}());



/***/ }),

/***/ "./src/app/app.module.ts":
/*!*******************************!*\
  !*** ./src/app/app.module.ts ***!
  \*******************************/
/*! exports provided: AppModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "AppModule", function() { return AppModule; });
/* harmony import */ var _angular_platform_browser__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/platform-browser */ "./node_modules/@angular/platform-browser/fesm5/platform-browser.js");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/forms */ "./node_modules/@angular/forms/fesm5/forms.js");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/common/http */ "./node_modules/@angular/common/fesm5/http.js");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/fesm5/router.js");
/* harmony import */ var _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @ng-bootstrap/ng-bootstrap */ "./node_modules/@ng-bootstrap/ng-bootstrap/fesm5/ng-bootstrap.js");
/* harmony import */ var _app_component__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ./app.component */ "./src/app/app.component.ts");
/* harmony import */ var _nav_menu_nav_menu_component__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ./nav-menu/nav-menu.component */ "./src/app/nav-menu/nav-menu.component.ts");
/* harmony import */ var _home_home_component__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! ./home/home.component */ "./src/app/home/home.component.ts");
/* harmony import */ var _setup_setup_component__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! ./setup/setup.component */ "./src/app/setup/setup.component.ts");
/* harmony import */ var _inventario_inventario_component__WEBPACK_IMPORTED_MODULE_10__ = __webpack_require__(/*! ./inventario/inventario.component */ "./src/app/inventario/inventario.component.ts");
/* harmony import */ var _inventario_data_transfer_service__WEBPACK_IMPORTED_MODULE_11__ = __webpack_require__(/*! ./inventario/data-transfer.service */ "./src/app/inventario/data-transfer.service.ts");
/* harmony import */ var _invent_emb_modal_invent_emb_modal_component__WEBPACK_IMPORTED_MODULE_12__ = __webpack_require__(/*! ./invent-emb-modal/invent-emb-modal.component */ "./src/app/invent-emb-modal/invent-emb-modal.component.ts");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_13__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/fesm5/common.js");
/* harmony import */ var _angular_common_locales_pt__WEBPACK_IMPORTED_MODULE_14__ = __webpack_require__(/*! @angular/common/locales/pt */ "./node_modules/@angular/common/locales/pt.js");
/* harmony import */ var _angular_common_locales_pt__WEBPACK_IMPORTED_MODULE_14___default = /*#__PURE__*/__webpack_require__.n(_angular_common_locales_pt__WEBPACK_IMPORTED_MODULE_14__);
/* harmony import */ var _erros_modal_erros_modal_component__WEBPACK_IMPORTED_MODULE_15__ = __webpack_require__(/*! ./erros-modal/erros-modal.component */ "./src/app/erros-modal/erros-modal.component.ts");
/* harmony import */ var _impressao_modal_impressao_modal_component__WEBPACK_IMPORTED_MODULE_16__ = __webpack_require__(/*! ./impressao-modal/impressao-modal.component */ "./src/app/impressao-modal/impressao-modal.component.ts");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};

















Object(_angular_common__WEBPACK_IMPORTED_MODULE_13__["registerLocaleData"])(_angular_common_locales_pt__WEBPACK_IMPORTED_MODULE_14___default.a);
var AppModule = /** @class */ (function () {
    function AppModule() {
    }
    AppModule = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
            declarations: [
                _app_component__WEBPACK_IMPORTED_MODULE_6__["AppComponent"],
                _nav_menu_nav_menu_component__WEBPACK_IMPORTED_MODULE_7__["NavMenuComponent"],
                _home_home_component__WEBPACK_IMPORTED_MODULE_8__["HomeComponent"],
                _setup_setup_component__WEBPACK_IMPORTED_MODULE_9__["SetupComponent"],
                _inventario_inventario_component__WEBPACK_IMPORTED_MODULE_10__["InventarioComponent"],
                _invent_emb_modal_invent_emb_modal_component__WEBPACK_IMPORTED_MODULE_12__["InventEmbModalComponent"],
                _erros_modal_erros_modal_component__WEBPACK_IMPORTED_MODULE_15__["ErrosModalComponent"],
                _impressao_modal_impressao_modal_component__WEBPACK_IMPORTED_MODULE_16__["ImpressaoModalComponent"],
                _inventario_inventario_component__WEBPACK_IMPORTED_MODULE_10__["FilterPipe"]
            ],
            imports: [
                _angular_platform_browser__WEBPACK_IMPORTED_MODULE_0__["BrowserModule"].withServerTransition({ appId: 'ng-cli-universal' }),
                _angular_common_http__WEBPACK_IMPORTED_MODULE_3__["HttpClientModule"],
                _angular_forms__WEBPACK_IMPORTED_MODULE_2__["FormsModule"],
                _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_5__["NgbModule"].forRoot(),
                _angular_router__WEBPACK_IMPORTED_MODULE_4__["RouterModule"].forRoot([
                    { path: '', component: _home_home_component__WEBPACK_IMPORTED_MODULE_8__["HomeComponent"], pathMatch: 'full' },
                    { path: 'inventario', component: _inventario_inventario_component__WEBPACK_IMPORTED_MODULE_10__["InventarioComponent"] },
                    { path: 'setup', component: _setup_setup_component__WEBPACK_IMPORTED_MODULE_9__["SetupComponent"] }
                ])
            ],
            providers: [_inventario_data_transfer_service__WEBPACK_IMPORTED_MODULE_11__["DataTransferService"], { provide: _angular_core__WEBPACK_IMPORTED_MODULE_1__["LOCALE_ID"], useValue: 'pt-BR' }, _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_5__["NgbActiveModal"]],
            exports: [_inventario_inventario_component__WEBPACK_IMPORTED_MODULE_10__["FilterPipe"]],
            bootstrap: [_app_component__WEBPACK_IMPORTED_MODULE_6__["AppComponent"]], entryComponents: [_invent_emb_modal_invent_emb_modal_component__WEBPACK_IMPORTED_MODULE_12__["InventEmbModalComponent"], _erros_modal_erros_modal_component__WEBPACK_IMPORTED_MODULE_15__["ErrosModalComponent"], _impressao_modal_impressao_modal_component__WEBPACK_IMPORTED_MODULE_16__["ImpressaoModalComponent"]]
        })
    ], AppModule);
    return AppModule;
}());



/***/ }),

/***/ "./src/app/erros-modal/erros-modal.component.css":
/*!*******************************************************!*\
  !*** ./src/app/erros-modal/erros-modal.component.css ***!
  \*******************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "\n\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzcmMvYXBwL2Vycm9zLW1vZGFsL2Vycm9zLW1vZGFsLmNvbXBvbmVudC5jc3MifQ== */"

/***/ }),

/***/ "./src/app/erros-modal/erros-modal.component.html":
/*!********************************************************!*\
  !*** ./src/app/erros-modal/erros-modal.component.html ***!
  \********************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "<div role=\"document\" class=\"container\" style=\"margin-top: 15px; margin-bottom: 15px;\">\n  <div class=\"modal-content\">\n    <div class=\"modal-header\">\n      <h4 class=\"modal-title\">{{title}}</h4>\n      <button type=\"button\" class=\"close\" aria-label=\"Close\" (click)=\"activeModal.dismiss('Cross click')\">\n        <span aria-hidden=\"true\">&times;</span>\n      </button>\n    </div>\n    <div class=\"modal-body\">\n      <div class=\"container\">\n        <div style=\"white-space: pre-line\">{{erros}}</div>\n      </div>\n    </div>\n    <div class=\"modal-footer\">\n      <button type=\"button\" class=\"btn btn-primary\" (click)=\"activeModal.close('bnt fechar')\">Fechar</button>\n    </div>\n  </div>\n</div>\n"

/***/ }),

/***/ "./src/app/erros-modal/erros-modal.component.ts":
/*!******************************************************!*\
  !*** ./src/app/erros-modal/erros-modal.component.ts ***!
  \******************************************************/
/*! exports provided: ErrosModalComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ErrosModalComponent", function() { return ErrosModalComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @ng-bootstrap/ng-bootstrap */ "./node_modules/@ng-bootstrap/ng-bootstrap/fesm5/ng-bootstrap.js");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (undefined && undefined.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};


var ErrosModalComponent = /** @class */ (function () {
    function ErrosModalComponent(activeModal) {
        this.activeModal = activeModal;
    }
    ErrosModalComponent = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"])({
            selector: 'app-erros-modal',
            template: __webpack_require__(/*! ./erros-modal.component.html */ "./src/app/erros-modal/erros-modal.component.html"),
            styles: [__webpack_require__(/*! ./erros-modal.component.css */ "./src/app/erros-modal/erros-modal.component.css")]
        })
        /** errosModal component*/
        ,
        __metadata("design:paramtypes", [_ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_1__["NgbActiveModal"]])
    ], ErrosModalComponent);
    return ErrosModalComponent;
}());



/***/ }),

/***/ "./src/app/home/home.component.css":
/*!*****************************************!*\
  !*** ./src/app/home/home.component.css ***!
  \*****************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = ".thumbnail {\n  position: relative;\n}\n\n.caption {\n  position: absolute;\n  top: 45%;\n  left: 0;\n  width: 100%;\n}\n\n\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInNyYy9hcHAvaG9tZS9ob21lLmNvbXBvbmVudC5jc3MiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7RUFDRSxtQkFBbUI7Q0FDcEI7O0FBRUQ7RUFDRSxtQkFBbUI7RUFDbkIsU0FBUztFQUNULFFBQVE7RUFDUixZQUFZO0NBQ2IiLCJmaWxlIjoic3JjL2FwcC9ob21lL2hvbWUuY29tcG9uZW50LmNzcyIsInNvdXJjZXNDb250ZW50IjpbIi50aHVtYm5haWwge1xuICBwb3NpdGlvbjogcmVsYXRpdmU7XG59XG5cbi5jYXB0aW9uIHtcbiAgcG9zaXRpb246IGFic29sdXRlO1xuICB0b3A6IDQ1JTtcbiAgbGVmdDogMDtcbiAgd2lkdGg6IDEwMCU7XG59XG5cbiJdfQ== */"

/***/ }),

/***/ "./src/app/home/home.component.html":
/*!******************************************!*\
  !*** ./src/app/home/home.component.html ***!
  \******************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "<div class=\"container-fluid\">\n  <div class=\"row\">\n    <div class=\"thumbnail text-center  col-sm-12\">\n      <img src=\"../../assets/logoBacio.png\" class=\"float-left\" height=\"80vh\" width=\"auto\" />\n      <div class=\"caption\">\n        <h1 class=\"text-primary\" style=\"font-size: 3vw;\">Inventário Bacio di Latte</h1>\n      </div>\n    </div>\n  </div>\n  <div class=\"col-lg-12 w-100 h-100\">\n    <div class=\"float-left p-2\">\n      <em>{{loja}}</em><br>\n      <em *ngIf=\"ultSync\">Ultima Sincronização: {{ultSync}}</em>\n    </div>\n    <div class=\"row float-right\">\n      <button type=\"button\" (click)=\"novoInv()\" class=\"btn btn-primary\" style=\"margin-bottom: 20px; margin-right: 10px;\">Novo Inventário</button>\n      <button type=\"button\" (click)=\"printInv()\" class=\"btn btn-primary float-right\" style=\"margin-bottom: 20px;\">Imprimir</button>\n    </div>\n  </div>\n  <table class='table table-striped table-bordered'>\n    <thead>\n      <tr>\n        <th>Documento</th>\n        <th>Data</th>\n        <th>Status</th>\n        <th>Processando</th>\n        <th>Qtd. Proces.</th>\n        <th>Reenviar</th>\n        <th>Ações</th>\n      </tr>\n    </thead>\n    <tbody>\n      <tr *ngFor=\"let inv of cabInventarios\">\n        <td>{{ inv.documento }}</td>\n        <td>{{ inv.dataFormatted }}</td>\n        <td>{{ inv.status }}</td>\n        <td>{{ inv.lock }}</td>\n        <td>{{ inv.qtdSync }}</td>\n        <td>{{ inv.retry }}</td>\n        <td>\n          <button type=\"button\" class=\"btn btn-primary btn-sm\" (click)=\"altInv(inv.id)\" data-toggle=\"tooltip\" title=\"Editar Inventário\">Editar</button>\n          <button *ngIf=\"inv.hasError\" type=\"button\" class=\"btn btn-primary btn-sm\" (click)=\"showErrors(inv.id)\" data-toggle=\"tooltip\" title=\"Transmissão com erros\">Vis. Erro</button>\n          <button *ngIf=\"inv.status=='NaoFinalizado'\" type=\"button\" class=\"btn btn-primary btn-sm\" (click)=\"finInv(inv.id)\" data-toggle=\"tooltip\" title=\"Finalizar Digitação\">Finalizar</button>\n          <button type=\"button\" class=\"btn btn-primary btn-sm\" (click)=\"exportExcel(inv.id)\" data-toggle=\"tooltip\" title=\"Exportar Inventário Excel\">Excel</button>\n        </td>\n      </tr>\n    </tbody>\n  </table>\n  <div class=\"col-lg-12 w-100 h-100\" *ngIf=\"!cabInventarios\"><em>Carregando Inventários...</em></div>\n  <footer class=\"col-lg-12 w-100 h-100 text-center footer mt-auto py-3\" style=\"font-size: small\">\n    <div class=\"container text-muted\"><em>Versão 1.0.4</em></div>\n  </footer>\n</div>\n"

/***/ }),

/***/ "./src/app/home/home.component.ts":
/*!****************************************!*\
  !*** ./src/app/home/home.component.ts ***!
  \****************************************/
/*! exports provided: HomeComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "HomeComponent", function() { return HomeComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common/http */ "./node_modules/@angular/common/fesm5/http.js");
/* harmony import */ var _inventario_data_transfer_service__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../inventario/data-transfer.service */ "./src/app/inventario/data-transfer.service.ts");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/fesm5/router.js");
/* harmony import */ var _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ng-bootstrap/ng-bootstrap */ "./node_modules/@ng-bootstrap/ng-bootstrap/fesm5/ng-bootstrap.js");
/* harmony import */ var _erros_modal_erros_modal_component__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../erros-modal/erros-modal.component */ "./src/app/erros-modal/erros-modal.component.ts");
/* harmony import */ var _setup_setup_component__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ../setup/setup.component */ "./src/app/setup/setup.component.ts");
/* harmony import */ var _impressao_modal_impressao_modal_component__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ../impressao-modal/impressao-modal.component */ "./src/app/impressao-modal/impressao-modal.component.ts");
/* harmony import */ var rxjs__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! rxjs */ "./node_modules/rxjs/_esm5/index.js");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (undefined && undefined.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (undefined && undefined.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};









var HomeComponent = /** @class */ (function () {
    function HomeComponent(http, baseUrl, data, router, modalService, route) {
        this.http = http;
        this.data = data;
        this.router = router;
        this.modalService = modalService;
        this.route = route;
        this.ultSync = '';
        this.isSetted = false;
        this.baseUrl = baseUrl;
    }
    HomeComponent.prototype.ngOnInit = function () {
        var _this = this;
        this.data.currentInvId.subscribe(function (id) { return _this.invId = id; });
        this.checkSettings();
        this.getUltSync();
    };
    HomeComponent.prototype.checkSettings = function () {
        var _this = this;
        this.http.get(this.baseUrl + 'api/invent/setted').subscribe(function (result) {
            _this.isSetted = result.setted;
        }, function (error) { return console.log(error); }, function () {
            if (_this.isSetted) {
                _this.loadData();
                if (_this.loja === undefined) {
                    _this.getLoja();
                }
            }
            else {
                _this.firstRun();
            }
        });
    };
    HomeComponent.prototype.loadData = function () {
        var _this = this;
        this.http.get(this.baseUrl + 'api/invent/CabecInvent').subscribe(function (result) {
            _this.cabInventarios = result;
        }, function (error) { return console.error(error); });
    };
    HomeComponent.prototype.printInv = function () {
        this.modalService.open(_impressao_modal_impressao_modal_component__WEBPACK_IMPORTED_MODULE_7__["ImpressaoModalComponent"]);
    };
    HomeComponent.prototype.novoInv = function () {
        this.data.changeInvId(0);
        this.router.navigate(['/inventario']);
    };
    HomeComponent.prototype.altInv = function (id) {
        this.data.changeInvId(id);
        this.router.navigate(['/inventario']);
    };
    HomeComponent.prototype.firstRun = function () {
        var _this = this;
        var modal = this.modalService.open(_setup_setup_component__WEBPACK_IMPORTED_MODULE_6__["SetupComponent"], { backdrop: 'static', keyboard: false });
        modal.result.then(function () { _this.loadData(); });
    };
    HomeComponent.prototype.showErrors = function (invId) {
        var erros = this.cabInventarios.find(function (f) { return f.id == invId; }).errorMessage;
        var doc = this.cabInventarios.find(function (f) { return f.id == invId; }).documento;
        var modal = this.modalService.open(_erros_modal_erros_modal_component__WEBPACK_IMPORTED_MODULE_5__["ErrosModalComponent"]);
        modal.componentInstance.title = 'Erros do Inventario: ' + doc;
        modal.componentInstance.erros = erros;
    };
    HomeComponent.prototype.finInv = function (invId) {
        var _this = this;
        this.http.post(this.baseUrl + 'api/invent/FinInv/' + invId.toString(), "").subscribe(function (result) {
            console.log(result);
        }, function (error) { console.error(error), _this.loadData(); }, function () { return _this.loadData(); });
    };
    HomeComponent.prototype.exportExcel = function (invId) {
        //this.http.get<Response>(this.baseUrl + 'api/invent/exportexcel/' + invId.toString());
        window.location.href = this.baseUrl + 'api/invent/exportexcel/' + invId.toString();
    };
    HomeComponent.prototype.getUltSync = function () {
        var _this = this;
        this.ultSyncGetter$ = Object(rxjs__WEBPACK_IMPORTED_MODULE_8__["timer"])(0, 5000).subscribe(function () {
            _this.http.get(_this.baseUrl + 'api/invent/ultSync').subscribe(function (dt) { return _this.ultSync = dt.ultSync; }, function (err) { return console.log(err); });
        });
    };
    HomeComponent.prototype.getLoja = function () {
        var _this = this;
        this.http.get(this.baseUrl + 'api/invent/loja').subscribe(function (lj) {
            _this.http.get('./assets/lojas.json').subscribe(function (ljs) {
                ljs.lojas.forEach(function (element) {
                    if (element.armazem == lj.armazem && element.filial == lj.filial) {
                        _this.loja = element.loja + " - Armazém: " + element.armazem + " - Filial: " + element.filial;
                    }
                });
            }, function (err) { return console.log(err); });
        }, function (err) { return console.log(err); });
    };
    HomeComponent = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"])({
            selector: 'app-home',
            template: __webpack_require__(/*! ./home.component.html */ "./src/app/home/home.component.html"),
            styles: [__webpack_require__(/*! ./home.component.css */ "./src/app/home/home.component.css")],
        }),
        __param(1, Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Inject"])('BASE_URL')),
        __metadata("design:paramtypes", [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"], String, _inventario_data_transfer_service__WEBPACK_IMPORTED_MODULE_2__["DataTransferService"], _angular_router__WEBPACK_IMPORTED_MODULE_3__["Router"], _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_4__["NgbModal"], _angular_router__WEBPACK_IMPORTED_MODULE_3__["ActivatedRoute"]])
    ], HomeComponent);
    return HomeComponent;
}());



/***/ }),

/***/ "./src/app/impressao-modal/impressao-modal.component.css":
/*!***************************************************************!*\
  !*** ./src/app/impressao-modal/impressao-modal.component.css ***!
  \***************************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "\n\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzcmMvYXBwL2ltcHJlc3Nhby1tb2RhbC9pbXByZXNzYW8tbW9kYWwuY29tcG9uZW50LmNzcyJ9 */"

/***/ }),

/***/ "./src/app/impressao-modal/impressao-modal.component.html":
/*!****************************************************************!*\
  !*** ./src/app/impressao-modal/impressao-modal.component.html ***!
  \****************************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "<div role=\"document\" class=\"container\" style=\"margin-top: 15px; margin-bottom: 15px;\">\n  <div class=\"modal-content\">\n    <div class=\"modal-header\">\n      <h4 class=\"modal-title\">Impressão de Lista Para Contagem</h4>\n      <button type=\"button\" class=\"close\" aria-label=\"Close\" (click)=\"activeModal.dismiss('Cross click')\">\n        <span aria-hidden=\"true\">&times;</span>\n      </button>\n    </div>\n    <div class=\"modal-body\">\n      <div class=\"container\">\n        <table id=\"printTable\" border=\"1\">\n          <thead>\n            <tr>\n              <th width=\"40%\">PRODUTO</th>\n              <th width=\"20%\">FARDO / CAIXA</th>\n              <th width=\"20%\">BALDE / PACOTE</th>\n              <th width=\"20%\">KG / UND.</th>\n            </tr>\n          </thead>\n          <tbody>\n            <tr *ngFor=\"let prod of inventario.itens\">\n              <td>{{ prod.descricao }}</td>\n              <td></td>\n              <td></td>\n              <td></td>\n            </tr>\n          </tbody>\n        </table>\n      </div>\n    </div>    \n  </div>\n</div>\n\n"

/***/ }),

/***/ "./src/app/impressao-modal/impressao-modal.component.ts":
/*!**************************************************************!*\
  !*** ./src/app/impressao-modal/impressao-modal.component.ts ***!
  \**************************************************************/
/*! exports provided: ImpressaoModalComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ImpressaoModalComponent", function() { return ImpressaoModalComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common/http */ "./node_modules/@angular/common/fesm5/http.js");
/* harmony import */ var _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @ng-bootstrap/ng-bootstrap */ "./node_modules/@ng-bootstrap/ng-bootstrap/fesm5/ng-bootstrap.js");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (undefined && undefined.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (undefined && undefined.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var __awaiter = (undefined && undefined.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (undefined && undefined.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};



var ImpressaoModalComponent = /** @class */ (function () {
    function ImpressaoModalComponent(http, baseUrl, activeModal) {
        this.http = http;
        this.activeModal = activeModal;
        this.baseUrl = baseUrl;
    }
    ImpressaoModalComponent.prototype.ngOnInit = function () {
        var _this = this;
        var method = 'api/invent/prodmovest';
        this.http.get(this.baseUrl + method).subscribe(function (result) {
            _this.inventario = result;
        }, function (error) { return console.error(error); }, function () { return _this.imprimir(); });
    };
    ImpressaoModalComponent.prototype.delay = function (ms) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                return [2 /*return*/, new Promise(function (resolve) {
                        setTimeout(resolve, ms);
                    })];
            });
        });
    };
    ImpressaoModalComponent.prototype.imprimir = function () {
        return __awaiter(this, void 0, void 0, function () {
            var divToPrint, newWin;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, this.delay(500)];
                    case 1:
                        _a.sent();
                        divToPrint = document.getElementById("printTable");
                        newWin = window.open("");
                        newWin.document.write(divToPrint.outerHTML);
                        newWin.print();
                        newWin.close();
                        this.activeModal.close();
                        return [2 /*return*/];
                }
            });
        });
    };
    ImpressaoModalComponent = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"])({
            selector: 'app-impressao-modal',
            template: __webpack_require__(/*! ./impressao-modal.component.html */ "./src/app/impressao-modal/impressao-modal.component.html"),
            styles: [__webpack_require__(/*! ./impressao-modal.component.css */ "./src/app/impressao-modal/impressao-modal.component.css")]
        })
        /** ImpressaoModal component*/
        ,
        __param(1, Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Inject"])('BASE_URL')),
        __metadata("design:paramtypes", [_angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"], String, _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_2__["NgbActiveModal"]])
    ], ImpressaoModalComponent);
    return ImpressaoModalComponent;
}());



/***/ }),

/***/ "./src/app/invent-emb-modal/invent-emb-modal.component.css":
/*!*****************************************************************!*\
  !*** ./src/app/invent-emb-modal/invent-emb-modal.component.css ***!
  \*****************************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "\n\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzcmMvYXBwL2ludmVudC1lbWItbW9kYWwvaW52ZW50LWVtYi1tb2RhbC5jb21wb25lbnQuY3NzIn0= */"

/***/ }),

/***/ "./src/app/invent-emb-modal/invent-emb-modal.component.html":
/*!******************************************************************!*\
  !*** ./src/app/invent-emb-modal/invent-emb-modal.component.html ***!
  \******************************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "<div role=\"document\" class=\"container\" style=\"margin-top: 15px; margin-bottom: 15px;\">\n  <div class=\"modal-content\">\n    <div class=\"modal-header\">\n      <h4 class=\"modal-title\">{{invItemInv.descricao}}</h4>\n      <button type=\"button\" class=\"close\" aria-label=\"Close\" (click)=\"activeModal.dismiss('Cross click')\">\n        <span aria-hidden=\"true\">&times;</span>\n      </button>\n    </div>\n    <div class=\"modal-body\">\n      <div class=\"container\">\n        <div class=\"form-group\" *ngIf=\"invItemInv.descConversor1 != ' '\">\n          <label for=\"username\">{{invItemInv.descConversor1}}</label>\n          <input type=\"number\" class=\"form-control\" [(ngModel)]=\"invItemInv.qtdConv1\" (blur)=\"atualizaCusto()\" />\n        </div>\n        <div class=\"form-group\" *ngIf=\"invItemInv.descConversor2 != ' '\">\n          <label for=\"username\">{{invItemInv.descConversor2}}</label>\n          <input type=\"number\" class=\"form-control\" [(ngModel)]=\"invItemInv.qtdConv2\" (blur)=\"atualizaCusto()\" />\n        </div>\n        <div class=\"form-group\">\n          <label for=\"username\">{{invItemInv.descConversor3}}</label>\n          <input type=\"number\" class=\"form-control\" [(ngModel)]=\"invItemInv.qtdConv3\" (blur)=\"atualizaCusto()\" />\n        </div>\n        <div class=\"form-group float-right\">\n          <span>Valor Estoque: {{invItemInv.custo | currency:'BRL':'symbol' }}</span>\n        </div>\n      </div>\n    </div>\n    <div class=\"modal-footer\">\n      <button type=\"button\" class=\"btn btn-primary\" (click)=\"btnSave()\">Salvar</button>\n    </div>\n  </div>\n</div>\n"

/***/ }),

/***/ "./src/app/invent-emb-modal/invent-emb-modal.component.ts":
/*!****************************************************************!*\
  !*** ./src/app/invent-emb-modal/invent-emb-modal.component.ts ***!
  \****************************************************************/
/*! exports provided: InventEmbModalComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "InventEmbModalComponent", function() { return InventEmbModalComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @ng-bootstrap/ng-bootstrap */ "./node_modules/@ng-bootstrap/ng-bootstrap/fesm5/ng-bootstrap.js");
/* harmony import */ var _inventario_data_transfer_service__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../inventario/data-transfer.service */ "./src/app/inventario/data-transfer.service.ts");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (undefined && undefined.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};



var InventEmbModalComponent = /** @class */ (function () {
    function InventEmbModalComponent(activeModal, data) {
        this.activeModal = activeModal;
        this.data = data;
    }
    InventEmbModalComponent.prototype.ngOnInit = function () {
        var _this = this;
        this.data.currentInvItem.subscribe(function (item) { return _this.invItemInv = item; });
    };
    InventEmbModalComponent.prototype.atualizaCusto = function () {
        this.invItemInv.qtdProtheus = this.invItemInv.qtdConv1 * this.invItemInv.conversor1 +
            this.invItemInv.qtdConv2 * this.invItemInv.conversor2 +
            this.invItemInv.qtdConv3 * this.invItemInv.conversor3;
        this.invItemInv.custo = this.invItemInv.qtdProtheus * this.invItemInv.valorUnitario;
    };
    InventEmbModalComponent.prototype.btnSave = function () {
        var isToClose = true;
        var percDiff = (this.invItemInv.saldoEstoque - this.invItemInv.qtdProtheus) / this.invItemInv.saldoEstoque * -100;
        if (percDiff <= -15 || percDiff >= 15) {
            isToClose = confirm('A divergência do estoque sistêmico e o inventariado é de ' + percDiff.toFixed(2) + '%, Confirma esta quantidade?');
        }
        if (isToClose) {
            this.activeModal.close();
        }
    };
    InventEmbModalComponent = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"])({
            selector: 'app-invent-emb-modal',
            template: __webpack_require__(/*! ./invent-emb-modal.component.html */ "./src/app/invent-emb-modal/invent-emb-modal.component.html"),
            styles: [__webpack_require__(/*! ./invent-emb-modal.component.css */ "./src/app/invent-emb-modal/invent-emb-modal.component.css")]
        })
        /** InventEmbModal component*/
        ,
        __metadata("design:paramtypes", [_ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_1__["NgbActiveModal"], _inventario_data_transfer_service__WEBPACK_IMPORTED_MODULE_2__["DataTransferService"]])
    ], InventEmbModalComponent);
    return InventEmbModalComponent;
}());



/***/ }),

/***/ "./src/app/inventario/data-transfer.service.ts":
/*!*****************************************************!*\
  !*** ./src/app/inventario/data-transfer.service.ts ***!
  \*****************************************************/
/*! exports provided: DataTransferService */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DataTransferService", function() { return DataTransferService; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var rxjs__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! rxjs */ "./node_modules/rxjs/_esm5/index.js");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (undefined && undefined.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};


var DataTransferService = /** @class */ (function () {
    function DataTransferService() {
        this.invIdSource = new rxjs__WEBPACK_IMPORTED_MODULE_1__["BehaviorSubject"](0);
        this.currentInvId = this.invIdSource.asObservable();
        this.itemInv = {};
        this.invItemSource = new rxjs__WEBPACK_IMPORTED_MODULE_1__["BehaviorSubject"](this.itemInv);
        this.currentInvItem = this.invItemSource.asObservable();
    }
    DataTransferService.prototype.changeInvId = function (invId) {
        this.invIdSource.next(invId);
    };
    DataTransferService.prototype.changeInvItem = function (invItem) {
        this.invItemSource.next(invItem);
    };
    DataTransferService = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"])(),
        __metadata("design:paramtypes", [])
    ], DataTransferService);
    return DataTransferService;
}());



/***/ }),

/***/ "./src/app/inventario/inventario.component.css":
/*!*****************************************************!*\
  !*** ./src/app/inventario/inventario.component.css ***!
  \*****************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "\n\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzcmMvYXBwL2ludmVudGFyaW8vaW52ZW50YXJpby5jb21wb25lbnQuY3NzIn0= */"

/***/ }),

/***/ "./src/app/inventario/inventario.component.html":
/*!******************************************************!*\
  !*** ./src/app/inventario/inventario.component.html ***!
  \******************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "<div class=\"container-fluid\">\n  <div class=\"card\">\n    <div class=\"card-header bg-primary text-white\">\n      <strong class=\"card-title\" style=\"font-size:larger\">Inventário</strong>\n      <span class=\"badge badge-light text-primary float-lg-right\" *ngIf=\"vlrTotal\" style=\"font-size: larger\">{{vlrTotal | currency:'BRL':'symbol' }}</span>\n    </div>\n  </div>\n  <div class=\"card-body\">\n\n    <div class=\"row\">\n      <div class=\"form-group row\">\n\n        <!--Data-->\n        <div class=\"form-group row col-md-6 col-sm-12\">\n          <label for=\"txtDtInv\" class=\"col-lg-2 col-md-4 col-sm-12 col-form-label\">Mês:<span class=\"text-danger\">*</span></label>\n          <div class=\"col-lg-4 col-md-8 col-sm-12\">\n            <div class=\"input-group\">\n              <select class=\"form-control\" [(ngModel)]=\"mes\" >                \n                  <option *ngFor=\"let c of meses\" [ngValue]=\"c\">{{c.nome}}</option>                           \n                </select>              \n            </div>\n          </div>\n        </div>\n\n        <!--Documento-->\n        <div class=\"form-group row col-md-6 col-sm-12\">\n          <label for=\"txtDoc\" class=\"col-lg-2 col-md-4 col-sm-12 col-form-label\">Documento:</label>\n          <div class=\"col-lg-4 col-md-8 col-sm-12\">\n            <input type=\"text\" readonly class=\"form-control\" [(ngModel)]=\"inventario.documento\" id=\"txtDoc\">\n          </div>\n        </div>\n\n        <!--Busca-->\n        <div class=\"form-group row col-md-12\">\n          <label for=\"txtSearchString\" class=\"col-lg-2 col-md-2 col-form-label\">Pesquisar:</label>\n          <div class=\"col-lg-6 col-md-8 col-sm-12\">\n            <input type=\"text\" class=\"form-control\" [(ngModel)]=\"searchString\" name=\"searchString\" id=\"txtSearchString\" placeholder=\"Informe o produto que deseja pesquisar ...\">\n          </div>\n        </div>\n        <table class=\"table table-striped table-bordered\">\n          <thead>\n            <tr>\n              <th>Cód. Produto</th>\n              <th>Descrição</th>\n              <th>Und. Med.</th>\n              <th>Quantidade (kg/unid)</th>\n              <th>Vlr. Unit</th>\n              <th>Vlr. Estoque</th>\n              <th>Ações</th>\n            </tr>\n          </thead>\n          <tbody>\n            <tr *ngFor=\"let it of inventario.itens | filter : 'descricao' : searchString; let i = index\">\n              <td>{{it.codigo}}</td>\n              <td>\n                {{it.descricao}}\n              </td>\n              <td>{{it.um}}</td>\n              <td class=\"w-20\">\n                <div>\n                  <input type=\"number\" name=\"qtdProtheus\" class=\"form-control\" [(ngModel)]=\"it.qtdProtheus\" (focus)=\"setCurrent($event)\" (blur)=\"setValor(it)\" />\n                </div>\n              </td>\n              <td>{{it.valorUnitario | currency:'BRL':'symbol' }}</td>\n              <td>{{it.custo | currency:'BRL':'symbol' }}</td>\n              <td>\n                <button type=\"button\" class=\"btn btn-primary btn-sm\" (click)=\"detailEdit(it.produtoId)\" data-toggle=\"tooltip\" title=\"Informar quantidade por embalagem\">\n                  Invent. Outra Embalagem\n                </button>\n              </td>\n            </tr>\n          </tbody>\n        </table>\n        <div class=\"col-lg-12\">\n          <button type=\"button\" (click)=\"saveInv()\" [disabled]=\"gravarStat\" class=\"btn btn-primary float-right\">Gravar</button>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n"

/***/ }),

/***/ "./src/app/inventario/inventario.component.ts":
/*!****************************************************!*\
  !*** ./src/app/inventario/inventario.component.ts ***!
  \****************************************************/
/*! exports provided: FilterPipe, InventarioComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "FilterPipe", function() { return FilterPipe; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "InventarioComponent", function() { return InventarioComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/fesm5/router.js");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/common/http */ "./node_modules/@angular/common/fesm5/http.js");
/* harmony import */ var _inventario_data_transfer_service__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../inventario/data-transfer.service */ "./src/app/inventario/data-transfer.service.ts");
/* harmony import */ var _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @ng-bootstrap/ng-bootstrap */ "./node_modules/@ng-bootstrap/ng-bootstrap/fesm5/ng-bootstrap.js");
/* harmony import */ var _invent_emb_modal_invent_emb_modal_component__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../invent-emb-modal/invent-emb-modal.component */ "./src/app/invent-emb-modal/invent-emb-modal.component.ts");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (undefined && undefined.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (undefined && undefined.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};






//filtar produto
var FilterPipe = /** @class */ (function () {
    function FilterPipe() {
    }
    FilterPipe.prototype.transform = function (items, field, value) {
        if (!items) {
            return [];
        }
        if (!field || !value) {
            return items;
        }
        return items.filter(function (singleItem) {
            return singleItem[field].toLowerCase().includes(value.toLowerCase());
        });
    };
    FilterPipe = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Pipe"])({
            name: 'filter',
        }),
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"])()
    ], FilterPipe);
    return FilterPipe;
}());

var InventarioComponent = /** @class */ (function () {
    function InventarioComponent(http, baseUrl, modalService, data, router, route) {
        this.http = http;
        this.modalService = modalService;
        this.data = data;
        this.router = router;
        this.route = route;
        this.gravarStat = false;
        this.baseUrl = baseUrl;
        this.vlrTotal = 0;
        this.meses = [{ id: 0, nome: "Selecione o Mês" }, { id: 1, nome: "Janeiro" }, { id: 2, nome: "Fevereiro" }, { id: 3, nome: "Março" }, { id: 4, nome: "Abril" }, { id: 5, nome: "Maio" }, { id: 6, nome: "Junho" }, { id: 7, nome: "Julho" }, { id: 8, nome: "Agosto" }, { id: 9, nome: "Setembro" }, { id: 10, nome: "Outubro" }, { id: 11, nome: "Novembro" }, { id: 12, nome: "Dezembro" }];
        this.mes = this.meses[0];
    }
    InventarioComponent.prototype.ngOnInit = function () {
        var _this = this;
        this.data.currentInvId.subscribe(function (id) { return _this.invId = id; });
        this.data.currentInvItem.subscribe(function (item) { return _this.itemInv = item; });
        this.loadData();
    };
    InventarioComponent.prototype.loadData = function () {
        var _this = this;
        var method;
        if (this.invId === 0) {
            method = 'api/invent/prodmovest';
        }
        else {
            method = 'api/invent/ItensInvent/' + this.invId;
        }
        this.http.get(this.baseUrl + method).subscribe(function (result) {
            _this.inventario = result;
            var mes = +_this.inventario.data.substr(3, 2);
            _this.mes = _this.meses[mes];
        }, function (error) { return console.error(error); }, //tratamento de erro
        function () { return _this.updateVars(); }); //chamada quando a funcao estiver concluida
    };
    InventarioComponent.prototype.updateVars = function () {
        this.vlrTotal = 0;
        for (var _i = 0, _a = this.inventario.itens; _i < _a.length; _i++) {
            var it = _a[_i];
            this.vlrTotal += it.custo = it.qtdProtheus * it.valorUnitario;
        }
    };
    //Fix the confirm lack causing refocus
    InventarioComponent.prototype.setCurrent = function (event) {
        event.srcElement.setAttribute('origValue', event.target.value);
    };
    InventarioComponent.prototype.setValor = function (itemInv) {
        var index = this.inventario.itens.indexOf(itemInv);
        var item = itemInv;
        var qtd = item.qtdProtheus;
        var orig = +(event.srcElement.getAttribute('origValue'));
        var percDiff = (item.saldoEstoque !== 0) ? (item.saldoEstoque - qtd) / item.saldoEstoque * -100 : 100;
        if (qtd != orig) {
            if ((percDiff <= -15 || percDiff >= 15) && qtd !== 0) {
                if (confirm('A divergência do estoque sistêmico e o inventariado é de ' + percDiff.toFixed(2) + '%, Confirma esta quantidade?')) {
                    this.inventario.itens[index].qtdProtheus = qtd;
                    this.inventario.itens[index].qtdConv1 = 0;
                    this.inventario.itens[index].qtdConv2 = 0;
                    this.inventario.itens[index].qtdConv3 = this.inventario.itens[index].qtdProtheus;
                    this.inventario.itens[index].custo = this.inventario.itens[index].qtdProtheus * this.inventario.itens[index].valorUnitario;
                    this.updateVars();
                }
            }
        }
        return true;
    };
    InventarioComponent.prototype.detailEdit = function (produtoId) {
        var _this = this;
        var itemInv = this.inventario.itens.find(function (x) { return x.produtoId == produtoId; });
        var index = this.inventario.itens.findIndex(function (x) { return x.produtoId == produtoId; });
        this.data.changeInvItem(itemInv);
        var modal = this.modalService.open(_invent_emb_modal_invent_emb_modal_component__WEBPACK_IMPORTED_MODULE_5__["InventEmbModalComponent"], { size: 'lg' });
        modal.result.then(function () { _this.updateVars(); }, function () { console.log('Backdrop click'); });
    };
    InventarioComponent.prototype.saveInv = function () {
        var _this = this;
        if (this.mes === undefined || this.mes.id === 0) {
            alert("O mês deve ser informado");
            return;
        }
        this.gravarStat = true; //desabilita o botão
        var now = new Date(Date.now());
        var dtInv = new Date(((this.mes.id === 12 && now.getMonth() === 0) ? now.getFullYear() - 1 : now.getFullYear()), this.mes.id, 0);
        this.inventario.data = dtInv.getFullYear() + "-" + this.mes.id.toString().padStart(2, '0') + "-" + dtInv.getDate();
        this.fixItens(); //preenche com zero os campos deixados em branco
        var json = JSON.stringify(this.inventario);
        var head = new _angular_common_http__WEBPACK_IMPORTED_MODULE_2__["HttpHeaders"]({ 'Content-Type': 'application/json' });
        var metodo;
        if (this.invId === 0) {
            metodo = 'api/invent/IncInvent';
            this.http.post(this.baseUrl + metodo, json, { headers: head }).subscribe(function (result) { return console.info(result); }, function (error) { return console.log(error); }, function () { _this.router.navigate(['/']); });
        }
        else {
            metodo = 'api/invent/AltInvent/';
            this.http.put(this.baseUrl + metodo, json, { headers: head }).subscribe(function (result) { return console.info(result); }, function (error) { return console.log(error); }, function () { _this.router.navigate(['/']); });
        }
    };
    InventarioComponent.prototype.fixItens = function () {
        this.inventario.itens.forEach(function (val, idx, arr) {
            if (val.qtdConv1 == undefined) {
                val.qtdConv1 = 0;
            }
            if (val.qtdConv2 == undefined) {
                val.qtdConv2 = 0;
            }
            if (val.qtdConv3 == undefined) {
                val.qtdConv3 = 0;
            }
            if (val.qtdProtheus == undefined) {
                val.qtdProtheus = 0;
            }
        });
        this.updateVars();
    };
    InventarioComponent = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"])({
            selector: 'app-inventario',
            template: __webpack_require__(/*! ./inventario.component.html */ "./src/app/inventario/inventario.component.html"),
            styles: [__webpack_require__(/*! ./inventario.component.css */ "./src/app/inventario/inventario.component.css")],
        })
        /** inventario component*/
        ,
        __param(1, Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Inject"])('BASE_URL')),
        __metadata("design:paramtypes", [_angular_common_http__WEBPACK_IMPORTED_MODULE_2__["HttpClient"], String, _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_4__["NgbModal"], _inventario_data_transfer_service__WEBPACK_IMPORTED_MODULE_3__["DataTransferService"], _angular_router__WEBPACK_IMPORTED_MODULE_1__["Router"], _angular_router__WEBPACK_IMPORTED_MODULE_1__["ActivatedRoute"]])
    ], InventarioComponent);
    return InventarioComponent;
}());



/***/ }),

/***/ "./src/app/nav-menu/nav-menu.component.css":
/*!*************************************************!*\
  !*** ./src/app/nav-menu/nav-menu.component.css ***!
  \*************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "li .glyphicon {\n    margin-right: 10px;\n}\n\n/* Highlighting rules for nav menu items */\n\nli.link-active a,\nli.link-active a:hover,\nli.link-active a:focus {\n    background-color: #4189C7;\n    color: white;\n}\n\n/* Keep the nav menu independent of scrolling and on top of other items */\n\n.main-nav {\n    position: fixed;\n    top: 0;\n    left: 0;\n    right: 0;\n    z-index: 1;\n}\n\n@media (min-width: 768px) {\n    /* On small screens, convert the nav menu to a vertical sidebar */\n    .main-nav {\n        height: 100%;\n        width: calc(25% - 20px);\n    }\n    .navbar {\n        border-radius: 0px;\n        border-width: 0px;\n        height: 100%;\n    }\n    .navbar-header {\n        float: none;\n    }\n    .navbar-collapse {\n        border-top: 1px solid #444;\n        padding: 0px;\n    }\n    .navbar ul {\n        float: none;\n    }\n    .navbar li {\n        float: none;\n        font-size: 15px;\n        margin: 6px;\n    }\n    .navbar li a {\n        padding: 10px 16px;\n        border-radius: 4px;\n    }\n    .navbar a {\n        /* If a menu item's text is too long, truncate it */\n        width: 100%;\n        white-space: nowrap;\n        overflow: hidden;\n        text-overflow: ellipsis;\n    }\n}\n\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInNyYy9hcHAvbmF2LW1lbnUvbmF2LW1lbnUuY29tcG9uZW50LmNzcyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtJQUNJLG1CQUFtQjtDQUN0Qjs7QUFFRCwyQ0FBMkM7O0FBQzNDOzs7SUFHSSwwQkFBMEI7SUFDMUIsYUFBYTtDQUNoQjs7QUFFRCwwRUFBMEU7O0FBQzFFO0lBQ0ksZ0JBQWdCO0lBQ2hCLE9BQU87SUFDUCxRQUFRO0lBQ1IsU0FBUztJQUNULFdBQVc7Q0FDZDs7QUFFRDtJQUNJLGtFQUFrRTtJQUNsRTtRQUNJLGFBQWE7UUFDYix3QkFBd0I7S0FDM0I7SUFDRDtRQUNJLG1CQUFtQjtRQUNuQixrQkFBa0I7UUFDbEIsYUFBYTtLQUNoQjtJQUNEO1FBQ0ksWUFBWTtLQUNmO0lBQ0Q7UUFDSSwyQkFBMkI7UUFDM0IsYUFBYTtLQUNoQjtJQUNEO1FBQ0ksWUFBWTtLQUNmO0lBQ0Q7UUFDSSxZQUFZO1FBQ1osZ0JBQWdCO1FBQ2hCLFlBQVk7S0FDZjtJQUNEO1FBQ0ksbUJBQW1CO1FBQ25CLG1CQUFtQjtLQUN0QjtJQUNEO1FBQ0ksb0RBQW9EO1FBQ3BELFlBQVk7UUFDWixvQkFBb0I7UUFDcEIsaUJBQWlCO1FBQ2pCLHdCQUF3QjtLQUMzQjtDQUNKIiwiZmlsZSI6InNyYy9hcHAvbmF2LW1lbnUvbmF2LW1lbnUuY29tcG9uZW50LmNzcyIsInNvdXJjZXNDb250ZW50IjpbImxpIC5nbHlwaGljb24ge1xuICAgIG1hcmdpbi1yaWdodDogMTBweDtcbn1cblxuLyogSGlnaGxpZ2h0aW5nIHJ1bGVzIGZvciBuYXYgbWVudSBpdGVtcyAqL1xubGkubGluay1hY3RpdmUgYSxcbmxpLmxpbmstYWN0aXZlIGE6aG92ZXIsXG5saS5saW5rLWFjdGl2ZSBhOmZvY3VzIHtcbiAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjNDE4OUM3O1xuICAgIGNvbG9yOiB3aGl0ZTtcbn1cblxuLyogS2VlcCB0aGUgbmF2IG1lbnUgaW5kZXBlbmRlbnQgb2Ygc2Nyb2xsaW5nIGFuZCBvbiB0b3Agb2Ygb3RoZXIgaXRlbXMgKi9cbi5tYWluLW5hdiB7XG4gICAgcG9zaXRpb246IGZpeGVkO1xuICAgIHRvcDogMDtcbiAgICBsZWZ0OiAwO1xuICAgIHJpZ2h0OiAwO1xuICAgIHotaW5kZXg6IDE7XG59XG5cbkBtZWRpYSAobWluLXdpZHRoOiA3NjhweCkge1xuICAgIC8qIE9uIHNtYWxsIHNjcmVlbnMsIGNvbnZlcnQgdGhlIG5hdiBtZW51IHRvIGEgdmVydGljYWwgc2lkZWJhciAqL1xuICAgIC5tYWluLW5hdiB7XG4gICAgICAgIGhlaWdodDogMTAwJTtcbiAgICAgICAgd2lkdGg6IGNhbGMoMjUlIC0gMjBweCk7XG4gICAgfVxuICAgIC5uYXZiYXIge1xuICAgICAgICBib3JkZXItcmFkaXVzOiAwcHg7XG4gICAgICAgIGJvcmRlci13aWR0aDogMHB4O1xuICAgICAgICBoZWlnaHQ6IDEwMCU7XG4gICAgfVxuICAgIC5uYXZiYXItaGVhZGVyIHtcbiAgICAgICAgZmxvYXQ6IG5vbmU7XG4gICAgfVxuICAgIC5uYXZiYXItY29sbGFwc2Uge1xuICAgICAgICBib3JkZXItdG9wOiAxcHggc29saWQgIzQ0NDtcbiAgICAgICAgcGFkZGluZzogMHB4O1xuICAgIH1cbiAgICAubmF2YmFyIHVsIHtcbiAgICAgICAgZmxvYXQ6IG5vbmU7XG4gICAgfVxuICAgIC5uYXZiYXIgbGkge1xuICAgICAgICBmbG9hdDogbm9uZTtcbiAgICAgICAgZm9udC1zaXplOiAxNXB4O1xuICAgICAgICBtYXJnaW46IDZweDtcbiAgICB9XG4gICAgLm5hdmJhciBsaSBhIHtcbiAgICAgICAgcGFkZGluZzogMTBweCAxNnB4O1xuICAgICAgICBib3JkZXItcmFkaXVzOiA0cHg7XG4gICAgfVxuICAgIC5uYXZiYXIgYSB7XG4gICAgICAgIC8qIElmIGEgbWVudSBpdGVtJ3MgdGV4dCBpcyB0b28gbG9uZywgdHJ1bmNhdGUgaXQgKi9cbiAgICAgICAgd2lkdGg6IDEwMCU7XG4gICAgICAgIHdoaXRlLXNwYWNlOiBub3dyYXA7XG4gICAgICAgIG92ZXJmbG93OiBoaWRkZW47XG4gICAgICAgIHRleHQtb3ZlcmZsb3c6IGVsbGlwc2lzO1xuICAgIH1cbn1cbiJdfQ== */"

/***/ }),

/***/ "./src/app/nav-menu/nav-menu.component.html":
/*!**************************************************!*\
  !*** ./src/app/nav-menu/nav-menu.component.html ***!
  \**************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "<div class='main-nav'>\n    <div class='navbar navbar-inverse'>\n        <div class='navbar-header'>\n            <button type='button' class='navbar-toggle' data-toggle='collapse' data-target='.navbar-collapse' [attr.aria-expanded]='isExpanded' (click)='toggle()'>\n                <span class='sr-only'>Toggle navigation</span>\n                <span class='icon-bar'></span>\n                <span class='icon-bar'></span>\n                <span class='icon-bar'></span>\n            </button>\n            <a class='navbar-brand' [routerLink]='[\"/\"]'>bacioInventario</a>\n        </div>\n        <div class='clearfix'></div>\n        <div class='navbar-collapse collapse' [ngClass]='{ \"in\": isExpanded }'>\n            <ul class='nav navbar-nav'>\n                <li [routerLinkActive]='[\"link-active\"]' [routerLinkActiveOptions]='{ exact: true }'>\n                    <a [routerLink]='[\"/\"]' (click)='collapse()'>\n                        <span class='glyphicon glyphicon-home'></span> Home\n                    </a>\n                </li>\n                <li [routerLinkActive]='[\"link-active\"]'>\n                    <a [routerLink]='[\"/counter\"]' (click)='collapse()'>\n                        <span class='glyphicon glyphicon-education'></span> Counter\n                    </a>\n                </li>\n                <li [routerLinkActive]='[\"link-active\"]'>\n                    <a [routerLink]='[\"/fetch-data\"]' (click)='collapse()'>\n                        <span class='glyphicon glyphicon-th-list'></span> Fetch data\n                    </a>\n                </li>\n            </ul>\n        </div>\n    </div>\n</div>\n"

/***/ }),

/***/ "./src/app/nav-menu/nav-menu.component.ts":
/*!************************************************!*\
  !*** ./src/app/nav-menu/nav-menu.component.ts ***!
  \************************************************/
/*! exports provided: NavMenuComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "NavMenuComponent", function() { return NavMenuComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};

var NavMenuComponent = /** @class */ (function () {
    function NavMenuComponent() {
        this.isExpanded = false;
    }
    NavMenuComponent.prototype.collapse = function () {
        this.isExpanded = false;
    };
    NavMenuComponent.prototype.toggle = function () {
        this.isExpanded = !this.isExpanded;
    };
    NavMenuComponent = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"])({
            selector: 'app-nav-menu',
            template: __webpack_require__(/*! ./nav-menu.component.html */ "./src/app/nav-menu/nav-menu.component.html"),
            styles: [__webpack_require__(/*! ./nav-menu.component.css */ "./src/app/nav-menu/nav-menu.component.css")]
        })
    ], NavMenuComponent);
    return NavMenuComponent;
}());



/***/ }),

/***/ "./src/app/setup/setup.component.css":
/*!*******************************************!*\
  !*** ./src/app/setup/setup.component.css ***!
  \*******************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "\n\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzcmMvYXBwL3NldHVwL3NldHVwLmNvbXBvbmVudC5jc3MifQ== */"

/***/ }),

/***/ "./src/app/setup/setup.component.html":
/*!********************************************!*\
  !*** ./src/app/setup/setup.component.html ***!
  \********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = "<div role=\"document\" class=\"container\" style=\"margin-top: 15px; margin-bottom: 15px;\">\n  <div class=\"modal-content\">\n    <div class=\"modal-header\">\n      <h4 class=\"modal-title\">Configuração Inicial</h4>\n    </div>\n    <div class=\"modal-body\">\n      <div class=\"container\">\n        <div *ngIf=\"!lojas\"><em>Carregando Lojas ...</em></div>\n        <div *ngIf=\"lojas\">\n          <ng-template #rt let-r=\"result\" let-t=\"term\">\n            <ngb-highlight [result]=\"r.loja\" [term]=\"t\"></ngb-highlight>\n          </ng-template>\n\n          <label for=\"typeahead-focus\">Selecione a Loja:</label>\n          <input id=\"typeahead-focus\"\n                 type=\"text\"\n                 class=\"form-control\"\n                 [(ngModel)]=\"lojaSelect\"\n                 [ngbTypeahead]=\"search\"\n                 [resultTemplate]=\"rt\"\n                 [inputFormatter]=\"formatter\"\n                 placeholder=\"Digite para pesquisar ...\"\n                 (focus)=\"focus$.next($event.target.value)\"\n                 (click)=\"click$.next($event.target.value)\"\n                 #instance=\"ngbTypeahead\" />\n        </div>\n      </div>\n    </div>\n    <div class=\"modal-footer\">\n      <button type=\"button\" class=\"btn btn-primary\" (click)=\"setLoja()\">Salvar</button>\n    </div>\n  </div>\n</div>\n\n"

/***/ }),

/***/ "./src/app/setup/setup.component.ts":
/*!******************************************!*\
  !*** ./src/app/setup/setup.component.ts ***!
  \******************************************/
/*! exports provided: LojasService, SetupComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "LojasService", function() { return LojasService; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "SetupComponent", function() { return SetupComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @ng-bootstrap/ng-bootstrap */ "./node_modules/@ng-bootstrap/ng-bootstrap/fesm5/ng-bootstrap.js");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/common/http */ "./node_modules/@angular/common/fesm5/http.js");
/* harmony import */ var rxjs_index__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! rxjs/index */ "./node_modules/rxjs/index.js");
/* harmony import */ var rxjs_index__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(rxjs_index__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var rxjs_operators__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! rxjs/operators */ "./node_modules/rxjs/_esm5/operators/index.js");
var __decorate = (undefined && undefined.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (undefined && undefined.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (undefined && undefined.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};





var LojasService = /** @class */ (function () {
    function LojasService(baseUrl, http) {
        this.http = http;
        this.baseUrl = baseUrl;
    }
    LojasService.prototype.getLojas = function () {
        return this.http.get('./assets/lojas.json');
    };
    LojasService.prototype.setLoja = function (filial, armazem) {
        return this.http.post(this.baseUrl + 'api/invent/SetFilial?filial=' + filial + '&armazem=' + armazem, "");
    };
    LojasService = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"])(),
        __param(0, Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Inject"])('BASE_URL')),
        __metadata("design:paramtypes", [String, _angular_common_http__WEBPACK_IMPORTED_MODULE_2__["HttpClient"]])
    ], LojasService);
    return LojasService;
}());

var SetupComponent = /** @class */ (function () {
    /** setup ctor */
    function SetupComponent(activeModal, lojaService$) {
        var _this = this;
        this.activeModal = activeModal;
        this.lojaService$ = lojaService$;
        this.focus$ = new rxjs_index__WEBPACK_IMPORTED_MODULE_3__["Subject"]();
        this.click$ = new rxjs_index__WEBPACK_IMPORTED_MODULE_3__["Subject"]();
        this.search = function (text$) {
            var debouncedText$ = text$.pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_4__["debounceTime"])(200), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_4__["distinctUntilChanged"])());
            var clicksWithClosedPopup$ = _this.click$.pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_4__["filter"])(function () { return !_this.instance.isPopupOpen(); }));
            var inputFocus$ = _this.focus$;
            return Object(rxjs_index__WEBPACK_IMPORTED_MODULE_3__["merge"])(debouncedText$, inputFocus$, clicksWithClosedPopup$).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_4__["map"])(function (term) { return (term === '' ? _this.lojas.slice(0, 10)
                : _this.lojas.filter(function (v) { return v.loja.toLowerCase().indexOf(term.toLowerCase()) > -1; }).slice(0, 10)); }));
        };
        this.formatter = function (x) { return x.loja; };
    }
    SetupComponent.prototype.ngOnInit = function () {
        var _this = this;
        this.lojaService$.getLojas()
            .subscribe(function (res) { _this.lojas = res.lojas, console.log(res); }, function (error) { return console.log(error); });
    };
    SetupComponent.prototype.setLoja = function () {
        if (this.lojaSelect !== undefined && this.lojaSelect.loja !== undefined) {
            if (confirm("Confirma a seleção da loja: " + this.lojaSelect.loja + "?")) {
                this.lojaService$.setLoja(this.lojaSelect.filial, this.lojaSelect.armazem).subscribe(function (res) { return console.log(res); }, function (err) { return console.log(err); });
                this.activeModal.close();
            }
        }
        else {
            alert("Você deve selecionar uma loja antes de salvar");
        }
    };
    __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ViewChild"])('instance'),
        __metadata("design:type", _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_1__["NgbTypeahead"])
    ], SetupComponent.prototype, "instance", void 0);
    SetupComponent = __decorate([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"])({
            selector: 'setup',
            template: __webpack_require__(/*! ./setup.component.html */ "./src/app/setup/setup.component.html"),
            styles: [__webpack_require__(/*! ./setup.component.css */ "./src/app/setup/setup.component.css")],
            providers: [_ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_1__["NgbModal"], LojasService]
        })
        /** setup component*/
        ,
        __metadata("design:paramtypes", [_ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_1__["NgbActiveModal"], LojasService])
    ], SetupComponent);
    return SetupComponent;
}());



/***/ }),

/***/ "./src/environments/environment.ts":
/*!*****************************************!*\
  !*** ./src/environments/environment.ts ***!
  \*****************************************/
/*! exports provided: environment */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "environment", function() { return environment; });
// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `.angular-cli.json`.
var environment = {
    production: false
};


/***/ }),

/***/ "./src/main.ts":
/*!*********************!*\
  !*** ./src/main.ts ***!
  \*********************/
/*! exports provided: getBaseUrl */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "getBaseUrl", function() { return getBaseUrl; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/fesm5/core.js");
/* harmony import */ var _angular_platform_browser_dynamic__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/platform-browser-dynamic */ "./node_modules/@angular/platform-browser-dynamic/fesm5/platform-browser-dynamic.js");
/* harmony import */ var _app_app_module__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./app/app.module */ "./src/app/app.module.ts");
/* harmony import */ var _environments_environment__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./environments/environment */ "./src/environments/environment.ts");




function getBaseUrl() {
    return document.getElementsByTagName('base')[0].href;
}
var providers = [
    { provide: 'BASE_URL', useFactory: getBaseUrl, deps: [] }
];
if (_environments_environment__WEBPACK_IMPORTED_MODULE_3__["environment"].production) {
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["enableProdMode"])();
}
Object(_angular_platform_browser_dynamic__WEBPACK_IMPORTED_MODULE_1__["platformBrowserDynamic"])(providers).bootstrapModule(_app_app_module__WEBPACK_IMPORTED_MODULE_2__["AppModule"])
    .catch(function (err) { return console.log(err); });


/***/ }),

/***/ 0:
/*!***************************!*\
  !*** multi ./src/main.ts ***!
  \***************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__(/*! /mnt/c/Users/User/Documents/GitHub/bacioInventario/ClientApp/src/main.ts */"./src/main.ts");


/***/ })

},[[0,"runtime","vendor"]]]);
//# sourceMappingURL=main.js.map