{
  "name": "${PACKAGE_NAME}",
  "version": "${PACKAGE_VERSION}",
  "author": "${COMPANY}",
  "contributors": ["${AUTHORS}"],
  "dependencies": {
    "typescript": "^4.8.4",
    "publish": "^0.6.0",
    "npm-packlist-cli": "^1.0.0"
  },
  "types": "dist/**/*.d.ts",
  "files": [
    "dist/**/*"
  ],
  "publishConfig": {
    "access": "restricted"
  }
}
