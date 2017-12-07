var gulp = require('gulp');
var source = require('vinyl-source-stream');
var watchify = require('watchify');
var browserify = require('browserify');

gulp.task('default', function() {

    browserify({
        entries: ['./src/main.coffee'],
        extensions: ['.coffee'],
        debug: true
    })
    .transform('coffeeify')
    .bundle()
    .pipe(source('main.js'))
    .pipe(gulp.dest('./dist'));

});
