// Simplified SCORM 1.2 API implementation for testing
var API = {
  initialized: false,
  data: {},

  LMSInitialize: function(param) {
    this.initialized = true;
    console.log('SCORM: Initialized');
    return 'true';
  },

  LMSFinish: function(param) {
    console.log('SCORM: Finished');
    return 'true';
  },

  LMSGetValue: function(element) {
    console.log('SCORM: Get ' + element + ' = ' + (this.data[element] || ''));
    return this.data[element] || '';
  },

  LMSSetValue: function(element, value) {
    this.data[element] = value;
    console.log('SCORM: Set ' + element + ' = ' + value);
    return 'true';
  },

  LMSCommit: function(param) {
    console.log('SCORM: Committed data');
    return 'true';
  },

  LMSGetLastError: function() {
    return '0';
  },

  LMSGetErrorString: function(errorCode) {
    return '';
  },

  LMSGetDiagnostic: function(errorCode) {
    return '';
  }
};

// Convenience functions
function doLMSInitialize() { return API.LMSInitialize(''); }
function doLMSFinish() { return API.LMSFinish(''); }
function doLMSGetValue(element) { return API.LMSGetValue(element); }
function doLMSSetValue(element, value) { return API.LMSSetValue(element, value); }
function doLMSCommit() { return API.LMSCommit(''); }

// Common SCORM interactions
function markComplete() {
  doLMSSetValue('cmi.core.lesson_status', 'completed');
  doLMSCommit();
}

function setScore(raw, max, min) {
  doLMSSetValue('cmi.core.score.raw', raw);
  doLMSSetValue('cmi.core.score.max', max || '100');
  doLMSSetValue('cmi.core.score.min', min || '0');
  doLMSCommit();
}

function setLessonStatus(status) {
  doLMSSetValue('cmi.core.lesson_status', status);
  doLMSCommit();
}

// Initialize on page load
window.onload = function() {
  doLMSInitialize();
};