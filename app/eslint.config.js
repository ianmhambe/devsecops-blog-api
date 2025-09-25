import security from 'eslint-plugin-security';

export default [
  {
    languageOptions: {
      sourceType: 'module',
      globals: {
        node: true,
        es2021: true
      }
    },
    plugins: {
      security
    },
    rules: {
      ...security.configs.recommended.rules,
      'no-console': 'warn' // Changed from 'off' to 'warn'
    }
  }
];
