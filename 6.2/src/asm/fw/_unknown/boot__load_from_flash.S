/* boot__load_from_flash @ 0x8f2f9c, 440 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Boot is done from host
 *   flash_manager_run_inits error 1
 *   flash_manager_read_ids_section error 1
 *   MAC address from FLASH is %x:%x:%x
 *   Loading production line calibration values from FLASH
 *   ppm value from flash: %d
 *   PPM value too large (%d > %d), setting it to zero
 *   lo_power_xif_gc value from flash: %d
 * Зовут его: fw_main
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, boot__save_mac_address, flash_cfg__set_bb_sensor_calib, flash_cfg__set_lo_power_gc_ctrl, flash_cfg__set_lo_power_stg2_bias, flash_cfg__set_lo_power_xif_gc, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, hwd_abif__rx_table_config_vga_bias_all_rows
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__load_from_flash
boot__load_from_flash:
	.global L_8f2f9c
L_8f2f9c:
	push_s blink
L_8f2f9e:
	bl.d L_8c01dc
L_8f2fa2:
	mov_s r0,0x20
L_8f2fa4:
	mov_s r1,0x1001754
L_8f2faa:
	bl.d L_8dcba8
L_8f2fae:
	sub_s sp,sp,0x5c
L_8f2fb0:
	mov_s r2,sp
L_8f2fb2:
	mov_s r13,0x0
L_8f2fb4:
	mov_s r0,r13
L_8f2fb6:
	bl.d L_8f9294
L_8f2fba:
	mov_s r1,0x5c
L_8f2fbc:
	brne_s r0,0,L_8f2fcc
L_8f2fbe:
	mov_s r1,0x100176c
	.global L_8f2fc4
L_8f2fc4:
	bl.d L_8dcba8
L_8f2fc8:
	mov_s r0,r13
L_8f2fca:
	b_s L_8f314e
	.global L_8f2fcc
L_8f2fcc:
	mov_s r14,0x840040
L_8f2fd2:
	ld_s r0,[sp,0x2c]
L_8f2fd4:
	mov_s r1,0x4c
L_8f2fd6:
	bl.d L_8f9294
L_8f2fda:
	mov_s r2,r14
L_8f2fdc:
	brne_s r0,0,L_8f2fe6
L_8f2fde:
	mov_s r1,0x100178c
L_8f2fe4:
	b_s L_8f2fc4
	.global L_8f2fe6
L_8f2fe6:
	ldw r4,[r14, 0x2]
L_8f2fea:
	mov_s r1,0x10017b4
L_8f2ff0:
	ldw_s r2,[r14,0x6]
L_8f2ff2:
	mov_s r0,0x20
L_8f2ff4:
	bl.d L_8dcd00
L_8f2ff8:
	ldw_s r3,[r14,0x4]
L_8f2ffa:
	bl.d L_8e68f0
L_8f2ffe:
	add_s r0,r14,0x2
L_8f3000:
	mov_s r0,0x803b80
L_8f3006:
	stw_s r13,[r0,0x26]
L_8f3008:
	mov_s r1,0x10017d8
L_8f300e:
	bl.d L_8dcba8
L_8f3012:
	mov_s r0,0x20
L_8f3014:
	ldw_s r15,[r14,0x2c]
L_8f3016:
	mov_s r1,0x1001810
L_8f301c:
	mov_s r0,0x20
L_8f301e:
	bl.d L_8dcc10
L_8f3022:
	mov_s r2,r15
L_8f3024:
	cmp_s r15,0x3f
L_8f3026:
	bls_s L_8f303a
L_8f3028:
	mov_s r1,0x100182c
L_8f302e:
	mov_s r0,0x10
L_8f3030:
	mov_s r2,r15
L_8f3032:
	bl.d L_8dcc80
L_8f3036:
	mov_s r3,0x3f
L_8f3038:
	mov_s r15,r13
	.global L_8f303a
L_8f303a:
	bl.d L_8ce660
L_8f303e:
	extw_s r0,r15
L_8f3040:
	mov_s r13,0x1001860
L_8f3046:
	mov_s r0,0x20
L_8f3048:
	mov_s r1,r13
L_8f304a:
	bl.d L_8dcc10
L_8f304e:
	ldw_s r2,[r14,0x34]
L_8f3050:
	mov_s r0,0x20
L_8f3052:
	mov_s r1,r13
L_8f3054:
	bl.d L_8dcc10
L_8f3058:
	mov_s r2,0x0
L_8f305a:
	bl.d L_8e68ac
L_8f305e:
	mov_s r0,0x0
L_8f3060:
	ldw_s r13,[r14,0x36]
L_8f3062:
	mov_s r15,0x1001888
L_8f3068:
	mov_s r0,0x20
L_8f306a:
	mov_s r1,r15
L_8f306c:
	bl.d L_8dcc10
L_8f3070:
	mov_s r2,r13
L_8f3072:
	cmp_s r13,0x5
L_8f3074:
	mov.ls r13,0x5
L_8f3078:
	mov_s r0,0x20
L_8f307a:
	mov_s r1,r15
L_8f307c:
	bl.d L_8dcc10
L_8f3080:
	mov_s r2,r13
L_8f3082:
	brlo r13,0x10,L_8f3098
L_8f3086:
	mov_s r1,0x10018b0
L_8f308c:
	mov_s r0,0x10
L_8f308e:
	mov_s r2,r13
L_8f3090:
	bl.d L_8dcc80
L_8f3094:
	mov_s r3,0xf
L_8f3096:
	b_s L_8f30a0
	.global L_8f3098
L_8f3098:
	bl.d L_8e68a4
L_8f309c:
	ldb r0,[r14, 0x36]
	.global L_8f30a0
L_8f30a0:
	mov r16,0x10018e8
L_8f30a8:
	mov_s r13,0x840080
L_8f30ae:
	mov_s r0,0x20
L_8f30b0:
	mov_s r1,r16
L_8f30b2:
	bl.d L_8dcc10
L_8f30b6:
	ldw_s r2,[r13,0x2]
L_8f30b8:
	mov_s r15,0xf
L_8f30ba:
	stw_s r15,[r13,0x2]
L_8f30bc:
	mov_s r0,0x20
L_8f30be:
	mov_s r1,r16
L_8f30c0:
	bl.d L_8dcc10
L_8f30c4:
	mov_s r2,r15
L_8f30c6:
	ldw_s r2,[r13,0x2]
L_8f30c8:
	brlt r2,0x10,L_8f30de
L_8f30cc:
	mov_s r1,0x1001910
L_8f30d2:
	mov_s r0,0x0
L_8f30d4:
	bl.d L_8dcc80
L_8f30d8:
	mov_s r3,r15
L_8f30da:
	mov_s r2,0xc
L_8f30dc:
	stw_s r2,[r13,0x2]
	.global L_8f30de
L_8f30de:
	bl.d L_8e689c
L_8f30e2:
	extb_s r0,r2
L_8f30e4:
	ldw_s r15,[r14,0x38]
L_8f30e6:
	mov_s r1,0x100193c
L_8f30ec:
	mov_s r0,0x20
L_8f30ee:
	bl.d L_8dcc10
L_8f30f2:
	mov_s r2,r15
L_8f30f4:
	brlo r15,0x10,L_8f310a
L_8f30f8:
	mov_s r1,0x100195c
L_8f30fe:
	mov_s r0,0x10
L_8f3100:
	mov_s r2,r15
L_8f3102:
	bl.d L_8dcc80
L_8f3106:
	mov_s r3,0xf
L_8f3108:
	b_s L_8f3116
	.global L_8f310a
L_8f310a:
	extb_s r3,r15
L_8f310c:
	mov_s r0,0x0
L_8f310e:
	mov_s r1,0x3f
L_8f3110:
	bl.d L_8cf33c
L_8f3114:
	mov_s r2,0x1
	.global L_8f3116
L_8f3116:
	ldw_s r14,[r14,0x3a]
L_8f3118:
	mov_s r1,0x100198c
L_8f311e:
	mov_s r0,0x20
L_8f3120:
	bl.d L_8dcc10
L_8f3124:
	mov_s r2,r14
L_8f3126:
	brlo r14,0x10,L_8f313c
L_8f312a:
	mov_s r1,0x10019b4
L_8f3130:
	mov_s r0,0x10
L_8f3132:
	mov_s r2,r14
L_8f3134:
	bl.d L_8dcc80
L_8f3138:
	mov_s r3,0xf
L_8f313a:
	b_s L_8f3146
	.global L_8f313c
L_8f313c:
	extb_s r2,r14
L_8f313e:
	mov_s r0,0x0
L_8f3140:
	bl.d L_8cf550
L_8f3144:
	mov_s r1,0x3f
	.global L_8f3146
L_8f3146:
	ldw_s r0,[r13,0x6]
L_8f3148:
	bl.d L_8e62fc
L_8f314c:
	ldw_s r1,[r13,0x8]
	.global L_8f314e
L_8f314e:
	b.d L_8c0244
L_8f3152:
	add_s sp,sp,0x5c
