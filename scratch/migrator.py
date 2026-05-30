import os
import re

def migrate_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original = content
    
    # Imports
    content = re.sub(r'import .*/core/theme/app_colors\.dart.;', \"import 'package:gaspzero/shared/design_system/design_system.dart';\", content)
    content = re.sub(r'import .*/core/theme/app_text_styles\.dart.;', '', content)
    content = re.sub(r'import .*/shared/theme/app_colors\.dart. as shared_theme;', '', content)
    content = re.sub(r'import .*/shared/theme/app_colors\.dart.;', '', content)
    content = re.sub(r'import .gaspzero/core/theme/app_colors\.dart.;', \"import 'package:gaspzero/shared/design_system/design_system.dart';\", content)

    # Some replacements for Color(0xFF...)
    colors = {
        'Color(0xFF2D6C50)': 'AppColors.primary',
        'Color(0xFF131615)': 'AppColors.onBackground',
        'Color(0xFF4A5550)': 'AppColors.textSecondary',
        'Color(0xFF64748B)': 'AppColors.textTertiary',
        'Color(0xFF94A3B8)': 'AppColors.textMuted',
        'Color(0xFFE2E8F0)': 'AppColors.divider',
        'Color(0xFFDDDFE1)': 'AppColors.border',
        'Color(0xFFF6F7F7)': 'AppColors.background',
        'Color(0xFFFFFFFF)': 'AppColors.surface',
        'Color(0xFFB3261E)': 'AppColors.error',
        'Color(0xFFD1FAE5)': 'AppColors.statusActiveBackground',
        'Color(0xFF065F46)': 'AppColors.statusActiveText',
        'Color(0xFFFEF3C7)': 'AppColors.statusReservedBackground',
        'Color(0xFF92400E)': 'AppColors.statusReservedText',
        'Color(0xFFF0F1F2)': 'AppColors.lightGrayBackground',
        'Color(0xFFF5F5F5)': 'AppColors.statBackground',
    }
    
    for hex, prop in colors.items():
        content = content.replace(hex, prop)
        
    s_colors = {
        'shared_theme.AuthColors.lightGreenBackground': 'AppColors.lightGreenBackground',
        'shared_theme.AuthColors.iconsColor': 'AppColors.iconsColor',
        'shared_theme.AuthColors.lightGrayBackground': 'AppColors.lightGrayBackground',
        'shared_theme.AuthColors.statBackground': 'AppColors.statBackground',
    }
    for old, new in s_colors.items():
        content = content.replace(old, new)
        
    spacing_map = {
        'EdgeInsets.all(4)': 'EdgeInsets.all(AppSpacing.xs)',
        'EdgeInsets.all(4.0)': 'EdgeInsets.all(AppSpacing.xs)',
        'EdgeInsets.all(8)': 'EdgeInsets.all(AppSpacing.sm)',
        'EdgeInsets.all(8.0)': 'EdgeInsets.all(AppSpacing.sm)',
        'EdgeInsets.all(16)': 'EdgeInsets.all(AppSpacing.md)',
        'EdgeInsets.all(16.0)': 'EdgeInsets.all(AppSpacing.md)',
        'EdgeInsets.all(24)': 'EdgeInsets.all(AppSpacing.lg)',
        'EdgeInsets.all(24.0)': 'EdgeInsets.all(AppSpacing.lg)',
        'EdgeInsets.all(32)': 'EdgeInsets.all(AppSpacing.xl)',
        'EdgeInsets.all(32.0)': 'EdgeInsets.all(AppSpacing.xl)',
        
        'SizedBox(height: 4)': 'SizedBox(height: AppSpacing.xs)',
        'SizedBox(height: 4.0)': 'SizedBox(height: AppSpacing.xs)',
        'SizedBox(height: 8)': 'SizedBox(height: AppSpacing.sm)',
        'SizedBox(height: 8.0)': 'SizedBox(height: AppSpacing.sm)',
        'SizedBox(height: 12)': 'SizedBox(height: 12.0)',
        'SizedBox(height: 16)': 'SizedBox(height: AppSpacing.md)',
        'SizedBox(height: 16.0)': 'SizedBox(height: AppSpacing.md)',
        'SizedBox(height: 24)': 'SizedBox(height: AppSpacing.lg)',
        'SizedBox(height: 24.0)': 'SizedBox(height: AppSpacing.lg)',
        'SizedBox(height: 32)': 'SizedBox(height: AppSpacing.xl)',
        'SizedBox(height: 32.0)': 'SizedBox(height: AppSpacing.xl)',
        
        'SizedBox(width: 4)': 'SizedBox(width: AppSpacing.xs)',
        'SizedBox(width: 4.0)': 'SizedBox(width: AppSpacing.xs)',
        'SizedBox(width: 8)': 'SizedBox(width: AppSpacing.sm)',
        'SizedBox(width: 8.0)': 'SizedBox(width: AppSpacing.sm)',
        'SizedBox(width: 12)': 'SizedBox(width: 12.0)',
        'SizedBox(width: 16)': 'SizedBox(width: AppSpacing.md)',
        'SizedBox(width: 16.0)': 'SizedBox(width: AppSpacing.md)',
        'SizedBox(width: 24)': 'SizedBox(width: AppSpacing.lg)',
        'SizedBox(width: 24.0)': 'SizedBox(width: AppSpacing.lg)',
        'SizedBox(width: 32)': 'SizedBox(width: AppSpacing.xl)',
        'SizedBox(width: 32.0)': 'SizedBox(width: AppSpacing.xl)',
    }
    for old, new in spacing_map.items():
        content = content.replace(old, new)
        
    radius_map = {
        'BorderRadius.circular(8)': 'BorderRadius.circular(AppRadius.sm)',
        'BorderRadius.circular(8.0)': 'BorderRadius.circular(AppRadius.sm)',
        'BorderRadius.circular(12)': 'BorderRadius.circular(AppRadius.md)',
        'BorderRadius.circular(12.0)': 'BorderRadius.circular(AppRadius.md)',
        'BorderRadius.circular(16)': 'BorderRadius.circular(AppRadius.lg)',
        'BorderRadius.circular(16.0)': 'BorderRadius.circular(AppRadius.lg)',
        'BorderRadius.circular(24)': 'BorderRadius.circular(AppRadius.xl)',
        'BorderRadius.circular(24.0)': 'BorderRadius.circular(AppRadius.xl)',
        'BorderRadius.circular(9999)': 'BorderRadius.circular(AppRadius.full)',
        'BorderRadius.circular(9999.0)': 'BorderRadius.circular(AppRadius.full)',
    }
    for old, new in radius_map.items():
        content = content.replace(old, new)

    if content != original:
        # Check if design_system is imported
        if 'package:gaspzero/shared/design_system/design_system.dart' not in content:
            if 'import' in content:
                content = content.replace('import', \"import 'package:gaspzero/shared/design_system/design_system.dart';\\nimport\", 1)
            else:
                content = \"import 'package:gaspzero/shared/design_system/design_system.dart';\\n\" + content
                
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)

dirs_to_check = ['lib/features', 'lib/shared/widgets']
for d in dirs_to_check:
    for root, dirs, files in os.walk(d):
        for file in files:
            if file.endswith('.dart'):
                migrate_file(os.path.join(root, file))

print('Migration complete')
