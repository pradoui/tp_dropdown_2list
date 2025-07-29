# Publishing Instructions

This document contains instructions for publishing the `dropdown_2list` package to GitHub and pub.dev.

## Prerequisites

1. **GitHub Account**: Make sure you have a GitHub account
2. **pub.dev Account**: Create an account on [pub.dev](https://pub.dev)
3. **Flutter SDK**: Ensure you have Flutter installed and configured

## Step 1: Update Repository URLs

Before publishing, update the following URLs in `pubspec.yaml` with your actual GitHub username:

```yaml
homepage: https://github.com/YOUR_USERNAME/dropdown_2list
repository: https://github.com/YOUR_USERNAME/dropdown_2list
issue_tracker: https://github.com/YOUR_USERNAME/dropdown_2list/issues
documentation: https://github.com/YOUR_USERNAME/dropdown_2list#readme
```

Also update the GitHub URLs in:
- `README.md`
- `.github/workflows/ci.yml`

## Step 2: GitHub Repository Setup

1. **Create Repository**: Create a new repository on GitHub named `dropdown_2list`
2. **Push Code**: Push your code to the repository:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/dropdown_2list.git
   git push -u origin main
   ```

## Step 3: Test the Package

Before publishing, test the package:

```bash
# Run tests
flutter test

# Run example
cd example
flutter pub get
flutter run

# Analyze code
flutter analyze
```

## Step 4: Publish to pub.dev

1. **Login to pub.dev**:
   ```bash
   dart pub login
   ```

2. **Verify Package**:
   ```bash
   dart pub publish --dry-run
   ```

3. **Publish Package**:
   ```bash
   dart pub publish
   ```

## Step 5: Version Management

When making updates:

1. **Update Version**: Increment the version in `pubspec.yaml`
2. **Update CHANGELOG**: Add changes to `CHANGELOG.md`
3. **Test**: Run tests and verify functionality
4. **Publish**: Use `dart pub publish`

### Version Format

Use semantic versioning (MAJOR.MINOR.PATCH):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

## Step 6: Documentation

After publishing:

1. **Update README**: Ensure all examples work
2. **Add Screenshots**: Consider adding screenshots to the README
3. **Update pub.dev**: The package page will be automatically generated

## Troubleshooting

### Common Issues

1. **Package Name Conflict**: If the package name is taken, choose a different name
2. **Analysis Issues**: Fix any analysis warnings before publishing
3. **Test Failures**: Ensure all tests pass before publishing

### Support

For issues with publishing:
- [pub.dev Publishing Guide](https://dart.dev/tools/pub/publishing)
- [Flutter Package Publishing](https://flutter.dev/docs/development/packages-and-plugins/developing-packages)

## Maintenance

After publishing:

1. **Monitor Issues**: Check GitHub issues regularly
2. **Update Dependencies**: Keep dependencies up to date
3. **Security Updates**: Address security vulnerabilities promptly
4. **Community**: Respond to questions and contributions 