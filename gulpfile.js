const gulp = require('gulp');

const pug = require('gulp-pug');
const less = require('gulp-less');
const coffee = require('gulp-coffeescript');

gulp.task('watch', () => {
  gulp.watch('src/*.coffee', ['js'])
  gulp.watch('src/*.pug', ['html'])
  gulp.watch('src/*.less', ['css'])
});

gulp.task('default', ['html', 'css', 'js']);

gulp.task('html', () =>
  gulp
    .src('src/*.pug')
    .pipe(pug())
    .pipe(gulp.dest('public'))
);

gulp.task('css', () =>
  gulp
    .src('src/*.less')
    .pipe(less())
    .pipe(gulp.dest('public'))
);

gulp.task('js', () =>
  gulp
    .src('src/*.coffee')
    .pipe(coffee({ bare: true }))
    .pipe(gulp.dest('public'))
);
