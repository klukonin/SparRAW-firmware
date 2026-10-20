/* hwd__program_889_group @ 0x8d31dc, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__program_rf_clocks, init_rf_hw
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_abif__dvs_lo_splitter_config_buf_val
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd__program_889_group
hwd__program_889_group:
	.global L_8d31dc
L_8d31dc:
	push_s blink
L_8d31de:
	bl.d L_8c01dc
L_8d31e2:
	mov_s r1,0xff
L_8d31e4:
	mov_s r15,0x889400
L_8d31ea:
	mov_s r14,0x889480
L_8d31f0:
	mov_s r2,0xff00ffff
L_8d31f6:
	mov r16,0x889000
L_8d31fe:
	mov_s r3,0x889100
L_8d3204:
	mov_s r13,0x889380
L_8d320a:
	asl_s r1,r1,0x10
L_8d320c:
	brne r0,0x1,L_8d327c
L_8d3210:
	ld_s r0,[r15,0x1c]
L_8d3212:
	bclr_s r0,r0,0x3
L_8d3214:
	st_s r0,[r15,0x1c]
L_8d3216:
	ld_s r0,[r14,0x8]
L_8d3218:
	and_s r0,r0,r2
L_8d321a:
	or_s r0,r0,r1
L_8d321c:
	st_s r0,[r14,0x8]
L_8d321e:
	ld_s r0,[r3,0x54]
L_8d3220:
	bset_s r0,r0,0xb
L_8d3222:
	bset_s r0,r0,0x10
L_8d3224:
	st_s r0,[r3,0x54]
L_8d3226:
	ld_s r0,[r14,0x8]
L_8d3228:
	and_s r0,r0,r2
L_8d322a:
	st_s r0,[r14,0x8]
L_8d322c:
	mov_s r0,0x2
L_8d322e:
	bl.d L_8ce6fc
L_8d3232:
	mov_s r1,0x8
L_8d3234:
	ld r0,[r16, 0xf8]
L_8d3238:
	extw_s r0,r0
L_8d323a:
	bset r1,r0,0x13
L_8d323e:
	bset_s r1,r1,0x16
L_8d3240:
	bset_s r1,r1,0x17
L_8d3242:
	st r1,[r16, 0xf8]
L_8d3246:
	ld_s r0,[r13,0x14]
L_8d3248:
	bset_s r0,r0,0x0
L_8d324a:
	st_s r0,[r13,0x14]
L_8d324c:
	ld_s r0,[r14,0x20]
L_8d324e:
	bic r0,r0,0x1e0
L_8d3252:
	or r0,r0,0xc0
L_8d3256:
	st_s r0,[r14,0x20]
L_8d3258:
	ld_s r0,[r14,0x20]
L_8d325a:
	and r0,r0,0xffffe1ff
L_8d3262:
	bset_s r0,r0,0xa
L_8d3264:
	bset_s r0,r0,0xb
L_8d3266:
	bset_s r0,r0,0xc
L_8d3268:
	st_s r0,[r14,0x20]
L_8d326a:
	ld_s r0,[r14,0x20]
L_8d326c:
	and r0,r0,0xffe1ffff
L_8d3274:
	bset_s r0,r0,0x13
L_8d3276:
	bset_s r0,r0,0x14
L_8d3278:
	st_s r0,[r14,0x20]
L_8d327a:
	b_s L_8d329e
	.global L_8d327c
L_8d327c:
	ld_s r0,[r14,0x8]
L_8d327e:
	and_s r0,r0,r2
L_8d3280:
	or_s r0,r0,r1
L_8d3282:
	st_s r0,[r14,0x8]
L_8d3284:
	ld_s r0,[r3,0x54]
L_8d3286:
	bclr_s r0,r0,0xb
L_8d3288:
	bclr_s r0,r0,0x10
L_8d328a:
	st_s r0,[r3,0x54]
L_8d328c:
	ld_s r0,[r14,0x8]
L_8d328e:
	and_s r0,r0,r2
L_8d3290:
	st_s r0,[r14,0x8]
L_8d3292:
	ld_s r0,[r13,0x14]
L_8d3294:
	bclr_s r0,r0,0x0
L_8d3296:
	st_s r0,[r13,0x14]
L_8d3298:
	ld_s r0,[r15,0x1c]
L_8d329a:
	bset_s r0,r0,0x3
L_8d329c:
	st_s r0,[r15,0x1c]
	.global L_8d329e
L_8d329e:
	b L_8c0244
L_8d32a2:
	nop_s
