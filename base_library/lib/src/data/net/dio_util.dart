import 'package:dio/dio.dart';
import 'dart:io';
import '../protocol/base_resp.dart';
import 'dart:convert';

class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "-PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

class HttpConfig {
  String status;
  String code;
  String msg;
  String data;
  Options options;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PEM证书内容.
  String pem;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书路径.
  String pKCSPath;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书密码.
  String pKCSPwd;

  HttpConfig(
      {this.status,
      this.code,
      this.msg,
      this.data,
      this.options,
      this.pem,
      this.pKCSPath,
      this.pKCSPwd});
}

class DioUtil {
  static final DioUtil _singleton = DioUtil._init();
  static Dio _dio;
  String _statusKey = "status";
  String _codeKey = "errorCode";
  String _msgKey = "errorMsg";
  String _dataKey = "data";
  Options _options = getDefOptions();
  String _pem;
  String _pKCSPath;
  String _pKCSPwd;
  static bool _isDebug = false;

  static DioUtil getInstance() {
    _singleton;
  }

  factory DioUtil() {
    return _singleton;
  }

  DioUtil._init() {
    _dio = new Dio(_options);
  }

  static void openDebug() {
    _isDebug = true;
  }

  void setCookie(String cookie) {
    Map<String, dynamic> _headers = new Map();
    _headers["Cookie"] = cookie;
    _dio.options.headers.addAll(_headers);
  }

  void setConfig(HttpConfig config) {
    _statusKey = config.status ?? _statusKey;
    _codeKey = config.code ?? _codeKey;
    _msgKey = config.msg ?? _msgKey;
    _mergeOption(_options);
    _pem = config.pem ?? _pem;
    if (_dio != null) {
      _dio.options = _options;
      if (_pem != null) {
        _dio.onHttpClientCreate = (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            if (cert.pem == _pem) {
              //证书一致,放行
              return true;
            }
            return false;
          };
        };
      }
      if (_pKCSPath != null) {
        _dio.onHttpClientCreate = (HttpClient client) {
          SecurityContext sc = new SecurityContext();
          //file为证书路径
          sc.setTrustedCertificates(_pKCSPath, password: _pKCSPwd);
          HttpClient httpClient = new HttpClient(context: sc);
          return httpClient;
        };
      }
    }
  }

  void _mergeOption(Options options) {
    _options.method = options.method ?? _options.method;
    _options.headers = (new Map.from(_options.headers))
      ..addAll(options.headers);
    _options.baseUrl = options.baseUrl ?? _options.baseUrl;
    _options.connectTimeout = options.connectTimeout ?? _options.connectTimeout;
    _options.receiveTimeout = options.receiveTimeout ?? _options.receiveTimeout;
    _options.responseType = options.responseType ?? _options.responseType;
    _options.data = options.data ?? _options.data;
    _options.extra = (new Map.from(_options.extra))..addAll(options.extra);
    _options.contentType = options.contentType ?? _options.contentType;
    _options.validateStatus = options.validateStatus ?? _options.validateStatus;
    _options.followRedirects =
        options.followRedirects ?? _options.followRedirects;
  }

  static Options getDefOptions() {
    Options options = new Options();
    options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    options.connectTimeout = 1000 * 30;
    options.receiveTimeout = 1000 * 30;
    return options;
  }

  _checkOptions(String method, Options options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  String _getOptionsStr(Options request) {
    return "method: " +
        request.method +
        "  baseUrl: " +
        request.baseUrl +
        "  path: " +
        request.path;
  }

  void _printDataStr(String tag, Object value) {
    String da = value.toString();
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("[$tag  ]:   " + da.substring(0, 512));
        da = da.substring(512, da.length);
      } else {
        print("[$tag  ]:   " + da);
        da = "";
      }
    }
  }

  void _printHttpLog(Response response) {
    if (!_isDebug) {
      return;
    }
    try {
      print("----------------Http Log----------------" +
          "\n[statusCode]:   " +
          response.statusCode.toString() +
          "\n[request   ]:   " +
          _getOptionsStr(response.request));
      _printDataStr("reqdata ", response.request.data);
      _printDataStr("response", response.data);
    } catch (ex) {
      print("Http Log" + " error......");
    }
  }

  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return Map();
    }
    return json.decode(response.data.toString());
  }

  Future<BaseResp<T>> request<T>(String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    Response response = await _dio.request(path,
        data: data,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    _printHttpLog(response);

    String _status;
    int _code;
    String _msg;
    T _data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          _status = (response.data[_statusKey] is int)
              ? response.data[_statusKey].toString()
              : response.data[_statusKey];

          _code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_dataKey];
          _msg = response.data[_msgKey];
          _data = response.data[_dataKey];
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response);
          _status = (_dataMap[_statusKey] is int)
              ? _dataMap[_statusKey].toString()
              : _dataMap[_statusKey];
          _code = (_dataMap[_codeKey] is String)
              ? int.parse(_dataMap[_codeKey])
              : _dataMap[_codeKey];
          _msg = _dataMap[_msgKey];
          _data = _dataMap[_dataKey];
        }
        return new BaseResp(_status, _code, _msg, _data);
      } catch (e) {
        return new Future.error(new DioError(
            response: response,
            message: "data parsing exception...",
            type: DioErrorType.RESPONSE));
      }
    }

    return new Future.error(new DioError(
        response: response,
        message: "statusCode:${response.statusCode}, service error",
        type: DioErrorType.RESPONSE));
  }
}
