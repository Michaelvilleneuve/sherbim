'use strict';

/* ================================
 * Dependencies
 * ================================ */

var gulp         = require('gulp');
var sass         = require('gulp-sass');
var sourcemaps   = require('gulp-sourcemaps');
var autoprefixer = require('gulp-autoprefixer');
var rename       = require('gulp-rename');
var svgstore     = require('gulp-svgstore');
var browserSync  = require('browser-sync').create();
var notify       = require('gulp-notify');
var scsslint     = require('gulp-scss-lint');
var stylish      = require('gulp-scss-lint-stylish2');
var cssmin       = require('gulp-cssmin');
var jscs         = require('gulp-jscs');
var jsStylish    = require('gulp-jscs-stylish');
var imageOptim   = require('gulp-imageoptim');
var uglify       = require('gulp-uglify');
var insert       = require('gulp-insert');
var noop         = function () {};


function joinArray(array, before, after) {
  var string = '';
  for (var i = 0; i < array.length; i++) {
    string += before + array[i] + after;
  }
  return string;
}


/* ================================
 * Config variables
 * ================================ */

var docRoot = '';
var assets = docRoot + 'assets/';

// Sass options
var sassOptions = {
  src  : assets + 'scss/**/*.scss',
  dest : assets + 'css',
  opts : {
    outputStyle  : 'expanded',
    includePaths : ['./node_modules/sass-list-maps']
  }
};

// SCSS Lint options
var scssLintOptions = {
  src  : [assets + 'scss/**/*.scss'],
  opts : {
    config    : '.scss-lint.yml',
    maxBuffer : 10240000
  }
};

var cssminOptions = {
  src: [sassOptions.dest + '/*.css', sassOptions.dest + '/pages/*.css', sassOptions.dest + '/vendors/*.css'],
  dest: sassOptions.dest,
  opts: {
    mediaMerging: false,
    advanced: false,
    aggressiveMerging: false,
    processImport: false,
    rebase: false,
    restructuring: false,
    roundingPrecision: -1
  }
};

// JS Code Style options
var jscsOptions = {
  src  : [assets + 'js/*.js', assets + 'js/pages/*.js', assets + 'js/utils/*.js', assets + 'js/vendors/*.js'],
  opts : {
    config : '.jscsrc',
  }
};

// Autoprefixer options
var autoprefixerOptions = {
  browsers : ['last 4 versions', '> 0.2%', 'Firefox ESR']
};

// SVGStore options
var svgstoreOptions = {
  src  : assets + 'svg/sources/*.svg',
  dest : assets + 'svg',
  name : 'sprite.svg',
  opts : {
    inlineSvg  : true,
    formatting : {
      indent_size : 2
    }
  }
};

// ImageOptim options
var imageOptimOptions = {
  src  : [assets + 'img/**/*.jpg'],
  dest : assets + 'img'
}

// Notify options
var notifyOptions = {
  contentImage : __dirname + '/' + docRoot + '/android-chrome-96x96.png',
  sound        : false
};

// Browser Sync options
var browserSyncOptions = {
  watchTask : true,
  open      : false,
  proxy     : 'localhost'
};

// Watch options
var watchOptions = [
  // surveille les fichiers php pour l'intégration
  //docRoot + '/*.php',
  //docRoot + '/includes/.*.php',
  // surveille les fichiers js
  assets + 'js/*.js',
  assets + 'js/**/*.js',
  // surveille les fichiers de template
  assets + 'tpl/*.html',
  assets + 'tpl/*.html'
];



/* ================================
 * Tasks
 * ================================ */


// Sass compilation
gulp.task('sass', function () {
  notifyOptions.title   = 'Sass';
  notifyOptions.message = 'Le fichier <%= file.relative %> a été mis à jour';

  return gulp
    .src(sassOptions.src)
    .pipe(sourcemaps.init())
    .pipe(sass(sassOptions.opts).on('error', notify.onError({
        message: '<%= error.message %>'
      })).on('error', sass.logError))
    .pipe(autoprefixer(autoprefixerOptions))
    .pipe(gulp.dest(sassOptions.dest))
    .pipe(sourcemaps.write())
    .pipe(browserSync.stream())
    .pipe(notify(notifyOptions));
});



gulp.task('sassProd', function () {
  notifyOptions.title   = 'Sass';
  notifyOptions.message = 'Le fichier <%= file.relative %> a été mis à jour';

  sassOptions.opts.outputStyle = 'compressed';

  return gulp
    .src(sassOptions.src)
    .pipe(sourcemaps.init())
    .pipe(sass(sassOptions.opts).on('error', notify.onError({
        message: '<%= error.message %>'
      })).on('error', sass.logError))
    .pipe(autoprefixer(autoprefixerOptions))
    .pipe(gulp.dest(sassOptions.dest))
    .pipe(sourcemaps.write())
    .pipe(browserSync.stream())
    .pipe(notify(notifyOptions));
});


// SCSS Linting
gulp.task('scss-lint', function() {
  var reporter = stylish();
  scssLintOptions.opts.customReporter = reporter.issues;

  return gulp
    .src(scssLintOptions.src)
    .pipe(scsslint(scssLintOptions.opts))
    .pipe(reporter.printSummary);
});

// JS Code Style linting
gulp.task('js-lint', function () {

  return gulp.src(jscsOptions.src)
    .pipe(jscs())
    .on('error', noop)
    .pipe(jsStylish())
});


// Images optimization
gulp.task('image-optim', function() {

  return gulp
  .src(imageOptimOptions.src)
    .pipe(imageOptim.optimize())
    .pipe(gulp.dest(imageOptimOptions.dest));
});


// Sprite SVG
gulp.task('svgstore', function () {
  notifyOptions.title   = 'SVG Store';
  notifyOptions.message = 'Le fichier <%= file.relative %> a été mis à jour';

  return gulp
    .src(svgstoreOptions.src)
    .pipe(rename({prefix: 'svg-'}))
    .pipe(svgstore(svgstoreOptions.opts))
    .pipe(rename(svgstoreOptions.name))
    .pipe(gulp.dest(svgstoreOptions.dest))
    .pipe(notify(notifyOptions));
});

// Minify CSS
gulp.task('minify', function () {
    gulp.src(cssminOptions.src)
        .pipe(cssmin(cssminOptions.opts))
        .pipe(gulp.dest(function(file) {
          var path = file.base.replace('/css/', '/css/min/');
          return path;
        }));
});

// Uglify
gulp.task('uglify', function() {
  return gulp.src(jscsOptions.src)
    .pipe(uglify({
      preserveComments: function(node, comment) {
        if (comment.value.substr(0,2) === '!!') {
          return true;
        } else {
          return false;
        }
      },
      compress: {
        drop_console: true
      }
    }))
    .pipe(gulp.dest(function(file) {
      var path = file.base.replace('/js/', '/js/min/');
      return path;
    }));
});


// Compress
gulp.task('compress', ['minify', 'uglify'], function() {
  return gulp.src( assets +'js/min/vendors/console.js' )
    .pipe(insert.append(joinArray(logs, 'console.log(', ');')))
    .pipe(gulp.dest(function(file) {
      return file.base;
    }));
});


// Watch
gulp.task('watch', ['svgstore', 'sass'], function() {
  browserSync.init(browserSyncOptions);
  console.log(__dirname);

  gulp.watch(sassOptions.src, ['sass']);
  gulp.watch(jscsOptions.src, ['js-lint']);
  gulp.watch(svgstoreOptions.src, ['svgstore']);
  gulp.watch(watchOptions).on('change', browserSync.reload);
});


gulp.task('default', ['watch']);