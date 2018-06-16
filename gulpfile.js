const gulp = require('gulp');

const pug = require('gulp-pug');
const less = require('gulp-less');
const coffee = require('gulp-coffeescript');

gulp.task('watch', () => {
  gulp.run(['default'])
  gulp.watch('src/*.coffee', ['js'])
  gulp.watch('src/*.pug', ['html'])
  gulp.watch('src/*.less', ['css'])
  gulp.watch('src/media/*', ['media'])
});

gulp.task('default', ['html', 'css', 'js', 'media']);

gulp.task('html', () =>
  gulp
    .src('src/*.pug')
    .pipe(pug())
    .pipe(gulp.dest('build'))
);

gulp.task('css', () =>
  gulp
    .src('src/*.less')
    .pipe(less())
    .pipe(gulp.dest('build/styles'))
);

gulp.task('js', () =>
  gulp
    .src('src/*.coffee')
    .pipe(coffee({ bare: true }))
    .pipe(gulp.dest('build/scripts'))
);

gulp.task('media', () => {
  gulp
    .src('src/media/**')
    .pipe(gulp.dest('build/media'))
})
