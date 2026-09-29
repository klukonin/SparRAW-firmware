/* temp_sense__prepare_no_rf @ 0x8d7014, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: temp_sense__no_rf
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, hwd_abif__dvs_rfca_cmd_enable, rfc__read_block_34c, rfc__read_temperature
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global temp_sense__prepare_no_rf
temp_sense__prepare_no_rf:
	.global L_8d7014
L_8d7014:
	push_s blink
L_8d7016:
	bl L_8c01e0
L_8d701a:
	mov_s r13,r0
L_8d701c:
	mov_s r14,r1
L_8d701e:
	mov_s r15,r2
L_8d7020:
	mov_s r0,0x0
L_8d7022:
	stb.a r0,[sp,-0x4]
L_8d7026:
	mov_s r0,0x0
L_8d7028:
	bset r0,r0,r13
L_8d702c:
	extb_s r0,r0
L_8d702e:
	bl.d L_8ce910
L_8d7032:
	mov_s r1,sp
L_8d7034:
	cmp_s r14,0x0
L_8d7036:
	mov.ne r0,r13
L_8d703a:
	bl.ne.d L_8d3164
L_8d703e:
	mov.ne r1,r15
L_8d7042:
	mov_s r0,r13
L_8d7044:
	bl.d L_8d310c
L_8d7048:
	mov_s r1,r14
L_8d704a:
	mov_s r13,r0
L_8d704c:
	ldb_s r0,[sp,0x0]
L_8d704e:
	bl.d L_8ce910
L_8d7052:
	mov_s r1,0x0
L_8d7054:
	mov_s r0,r13
L_8d7056:
	b.d L_8c024c
L_8d705a:
	add_s sp,sp,0x4
