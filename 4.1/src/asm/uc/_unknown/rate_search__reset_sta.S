/* rate_search__reset_sta @ 0x92bd80, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__release_sta, bf_sm__reset_sta_rate, ucode_cmd_0x12_handler, ucode_cmd_0x30_handler, ucode_cmd__rs_enable
 * Зовёт сам: __ld_r13_ret_uc, rate_search__current_mcs, uc_sta_ctx__reset, uc_sta_trace__push_record
 * Глобалы (через gp): 0x8005a4
 */
	.section .text.rate_search__reset_sta,"ax",@progbits
	.global rate_search__reset_sta
rate_search__reset_sta:
	.global L_92bd80
L_92bd80:
	push_s blink
L_92bd82:
	push_s r13
L_92bd84:
	mov_s r13,r0
L_92bd86:
	bl.d L_931f54
L_92bd8a:
	mov_s r0,0x4
L_92bd8c:
	st.as r0,[gp,0x1f]
L_92bd90:
	mov_s r1,0x1
L_92bd92:
	asl_s r0,r13,0x2
L_92bd94:
	add1_s r0,r0,r0
L_92bd96:
	add r3,r0,0x8016d8
L_92bd9e:
	st_s r1,[r3,0x4]
L_92bda0:
	st_s r1,[r3,0x8]
L_92bda2:
	mov_s r0,0x0
L_92bda4:
	st_s r0,[r3]
L_92bda6:
	bl.d L_92c278
L_92bdaa:
	mov_s r0,r13
L_92bdac:
	ld.as r1,[gp,0x1f]
L_92bdb0:
	st_s r13,[r1,0x14]
L_92bdb2:
	ld.as r1,[gp,0x1f]
L_92bdb6:
	st_s r0,[r1,0x10]
L_92bdb8:
	ld_s r1,[r3,0x8]
L_92bdba:
	ld_s r0,[gp,0x7c]
L_92bdbc:
	st_s r1,[r0,0xc]
L_92bdbe:
	bl.d L_931ef8
L_92bdc2:
	mov_s r0,0x4
L_92bdc4:
	b L_92028c
