module.exports = {
    module: {
        rules: [
            {
                test: /\.coffee$/,
                use: [ 'coffee-loader' ]
            }
        ]
    }
}